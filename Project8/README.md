# 7 Swifty Words

A word-guessing game where players see a list of hints and an array of buttons with different letters on them, and need to use those buttons to enter words matching the hints.

## Main Topics Covered

- Creating UI in code
- Text alignment
- Layout margins
- `UIFont`

## Challenges
- [x] Use the techniques you learned in [project 2](../Project2) to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
- [x] If the user enters an incorrect guess, show an alert telling them they are wrong. You'll need to extend the `submitTapped()` method so that if `firstIndex(of:)` failed to find the guess you show an alert.
- [x] Try making the game also deduct points if the player makes an incorrect guess.
