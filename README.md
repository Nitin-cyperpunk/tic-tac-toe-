

# Tic Tac Toe on Stacks Blockchain

A decentralized implementation of the classic Tic Tac Toe game using the [Clarity](https://docs.stacks.co/docs/clarity/overview/) smart contract language for the Stacks blockchain.

## 🧠 Features

- Two-player game (X and O)
- On-chain turn-based logic
- Winner detection
- Board state storage and retrieval
- Game reset functionality

---

## 📁 Project Structure


tic-tac-toe/
├── contracts/
│   └── tic-tac-toe.clar     # Smart contract logic
├── Clarinet.toml            # Clarinet project config
└── README.md                # Project documentation


---

## 🚀 Getting Started

### Prerequisites

- [Clarinet](https://docs.stacks.co/docs/clarity/clarinet/overview/) (Stacks smart contract development toolchain)

Install Clarinet:

```bash
curl -sSfL https://get-clarinet.dev | bash
````

---

### Create and Run Project

```bash
# Create project
clarinet new tic-tac-toe
cd tic-tac-toe

# Replace contracts/tic-tac-toe.clar with the provided contract

# Launch the Clarinet console
clarinet console
```

---

## 🧪 Example Usage

### 1. Join Game

```lisp
(contract-call? .tic-tac-toe join-game)
```

First player becomes **X**, second becomes **O**.

---

### 2. Make Moves

```lisp
(contract-call? .tic-tac-toe make-move u0)
```

* Positions range from `u0` to `u8` (top-left to bottom-right).
* Game board is a 3x3 grid:

```
u0 | u1 | u2
------------
u3 | u4 | u5
------------
u6 | u7 | u8
```

---

### 3. View Board

```lisp
(contract-call? .tic-tac-toe get-board)
```

Returns the current board state (list of 9 optional values: `none`, `u1` for X, `u2` for O).

---

### 4. Reset Game

```lisp
(contract-call? .tic-tac-toe reset-game)
```

Resets all game state and allows new players to join.

---

## 🧠 Smart Contract Logic

* `player-x` and `player-o`: Store player principals.
* `board`: 9-cell list of optional uints (`u1` = X, `u2` = O).
* `turn`: Ensures correct turn order.
* `check-win`: Validates winning combinations.
* `game-over`: Prevents further moves after a win.

---

## ✅ Future Improvements

* Timeout for inactive players
* STX wager system
* Game history or leaderboard
* Web frontend using React + Clarity JS

---

## 📄 License

MIT License

## Contract Address
Address: ST221Z6TDTC5E0BYR2V624Q2ST6R0Q71T78WTAX6H

<img width="1437" alt="Screenshot 2025-06-02 at 2 51 11 PM" src="https://github.com/user-attachments/assets/83a6a636-27ca-40a4-a403-11b7a801eacd" />


```

---

Let me know if you’d like the README to include **screenshots**, **deployment instructions**, or a **frontend integration guide**!
```

