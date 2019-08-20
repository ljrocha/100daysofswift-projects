# Debugging

A technique project where we look at different ways to identify problems in our code.

## Main Topics Covered

- `print()`
- `assert()`
- Breakpoints
- View debugging

## Challenges
- [x] Temporarily try adding an exception breakpoint to [project 1](../Project1), then changing the call to `instantiateViewController()` so that is uses the storyboard identifier "Bad".
- [x] In [project 1](../Project1), add a call to `assert()` in the `viewDidLoad()` method of DetailViewController.swift, checking that `selectedImage` always has a value.
- [x] Go back to [project 5](../Project5), and try adding a conditional breakpoint to the start of the `submit()` method that pauses only if the user submits a word with six or more letters.
