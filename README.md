# War Card Game (Ruby)

A command-line implementation of a classic **War card game**, written in Ruby. Supports 2 to 4 players with automated round logic, recursive war resolution, and full deck handling.

---

## Requirements

- Ruby 2.6 or higher

---

## Installation & Usage

### 1. Clone or Download
Save the file `war_game.rb` to your local machine.

### 2. Run the Game
Navigate to the directory containing `war_game.rb` and run:

```bash
ruby war_game.rb
```

By default, it runs a 2-player game between **Alice** and **Bob**.

### 3. Run With Custom Players
You can pass 2 to 4 custom player names as command-line arguments:

```bash
ruby war_game.rb Alice Bob Charlie Dana
```

---

## Game Rules

- A standard 52-card deck is split evenly among players.
- In each round:
  - All players reveal their top card.
  - The highest card wins and takes all played cards.
  - Ties trigger a "war": tied players place 3 cards face-down, then play again.
  - This war process recurses until one winner emerges.
- A player is eliminated if they run out of cards.
- The game ends when one player has all 52 cards.

---

## Features

- Full 52-card deck generation and shuffle
- 2 to 4 player support
- Recursively handled "war" rounds
- Graceful handling when players run out of cards
- CLI-based logging of each round

---

## Example Output
```
-- Round 1 --
Alice plays K♠
Bob plays 7♥
Alice wins the round and takes 2 cards.

-- Round 2 --
Alice plays 4♣
Bob plays 4♠
WAR! Alice vs Bob
...
```
