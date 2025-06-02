(define-constant board-size u9)

(define-data-var player-x principal none)
(define-data-var player-o principal none)
(define-data-var board (list 9 (optional uint)) (list none none none none none none none none none))
(define-data-var turn principal tx-sender)
(define-data-var game-over bool false)

(define-public (join-game)
  (begin
    (if (is-none (var-get player-x))
        (begin
          (var-set player-x (some tx-sender))
          (ok "You are X"))
        (if (is-none (var-get player-o))
            (begin
              (var-set player-o (some tx-sender))
              (ok "You are O"))
            (err "Game already has 2 players")
        )
    )
  )
)

(define-private (get-player-symbol (player principal))
  (if (is-eq (some player) (var-get player-x))
      (some u1) ;; X = 1
      (if (is-eq (some player) (var-get player-o))
          (some u2) ;; O = 2
          none
      )
  )
)

(define-private (check-win (board (list 9 (optional uint))) (symbol uint))
  ;; List of all winning positions
  (let (
        (wins (list
                (tuple (a u0) (b u1) (c u2)) ;; row 1
                (tuple (a u3) (b u4) (c u5)) ;; row 2
                (tuple (a u6) (b u7) (c u8)) ;; row 3
                (tuple (a u0) (b u3) (c u6)) ;; col 1
                (tuple (a u1) (b u4) (c u7)) ;; col 2
                (tuple (a u2) (b u5) (c u8)) ;; col 3
                (tuple (a u0) (b u4) (c u8)) ;; diag 1
                (tuple (a u2) (b u4) (c u6)) ;; diag 2
              ))
      )
    (fold
      (lambda (win acc)
        (let (
              (a (get a win))
              (b (get b win))
              (c (get c win))
            )
          (if (and
                (is-some (get a board))
                (is-some (get b board))
                (is-some (get c board))
                (is-eq (unwrap-panic (get a board)) symbol)
                (is-eq (unwrap-panic (get b board)) symbol)
                (is-eq (unwrap-panic (get c board)) symbol)
              )
              true
              acc
          )
        )
      )
      false
      wins
    )
  )
)

(define-public (make-move (pos uint))
  (begin
    (if (var-get game-over)
        (err "Game is over")
    (if (>= pos u9)
        (err "Invalid position")
    (let (
          (player-symbol (get-player-symbol tx-sender))
          (current-board (var-get board))
        )
      (if (is-none player-symbol)
          (err "You are not in the game")
      (if (is-some (get pos current-board))
          (err "Cell already taken")
      (if (is-eq tx-sender (var-get turn))
        (let (
              (updated-board (map
                (lambda (cell idx)
                  (if (is-eq idx pos)
                      player-symbol
                      cell
                  )
                )
                current-board
              ))
              (next-turn (if (is-eq (var-get player-x) (some tx-sender))
                              (unwrap! (var-get player-o) (err "No O player"))
                              (unwrap! (var-get player-x) (err "No X player"))
                            ))
            )
          (begin
            (var-set board updated-board)
            (if (check-win updated-board (unwrap-panic player-symbol))
                (begin
                  (var-set game-over true)
                  (ok (concat "Winner: " (to-utf8 tx-sender)))
                )
                (begin
                  (var-set turn next-turn)
                  (ok "Move accepted")
                )
            )
          )
        )
        (err "Not your turn")
      )))))))
)

(define-public (get-board)
  (ok (var-get board))
)

(define-public (reset-game)
  (begin
    (var-set player-x none)
    (var-set player-o none)
    (var-set board (list none none none none none none none none none))
    (var-set turn tx-sender)
    (var-set game-over false)
    (ok "Game reset")
  )
)
