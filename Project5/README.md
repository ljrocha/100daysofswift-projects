# Word Scramble

A word game that deals with anagrams.

## Main Topics Covered

- Capture lists
- UITextField
- NSRange
- UITextChecker

## Challenges
- [x] Disallow answers that are shorter than three letters or are just the start word.
- [x] Refactor all the `else` statements we just added so that they call a new method called `showErrorMessage()`. This should accept an error message and a title, and do all the UIAlertController work from there.
- [x] Add a left bar button item that calls `startGame()`, so users can restart with a new word whenever they want to.
