# Fireworks Night

A SpriteKit game that lets players create fireworks displays using their fingers. Players need to touch or swipe fireworks of the same color, then shake their device to make them explode.

## Main Topics Covered

- `UIBezierPath`
- `SKAction.follow()`
- `for case let`
- Sprite color blending
- Detecting shake gestures

## Challenges
- [x] Add a score label that updates as the player's score changes.
- [x] Make the game end after a certain number of launches. You will need to use the `invalidate()` method of `Timer` to stop it from repeating.
- [x] Use the `waitForDuration` and `removeFromParent` actions in a sequence to make sure explosion particle emitters are removed from the game scene when they are finished.
