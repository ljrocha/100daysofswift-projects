# Space Race

A game about survival: the goal is to pilot a spaceship safely through a field of space junk. The longer you stay alive, the higher your score is.

## Main Topics Covered

- Pixel-perfect collision detection
- Advancing particle systems
- `Timer`
- `linearDamping`
- `angularDamping`

## Challenges
- [x] Stop the player from cheating by lifting their finger and tapping elsewhere - try implementing `touchesEnded()` to make it work.
- [x] Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it's triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call `invalidate()` on `gameTimer` before giving it a new value, otherwise you end up with multiple timers.
- [x] Stop creating space debris after the player has died.
