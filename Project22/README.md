# Detect-a-Beacon

An app that allows users to detect and range beacons.

## Main Topics Covered

- Core Location
- `CLLocationManager`
- `CLBeaconRegion`
- `CLProximity`

## Challenges
- [x] Write code that shows a `UIAlertController` when the beacon is first detected. Make sure you set a Boolean to say the alert has been shown, so it doesn't keep appearing.
- [x] Go through two or three other iBeacons in the Detect Beacon app and add their UUID's to your app, then register all of them with iOS. Now add a second label to the app that shows new text depending on which beacon was located.
- [x] Add a circle to your view, then use animation to scale it up and down depending on the distance from the beacon - try 0.001 for unknown, 0.25 for far, 0.5 for near, and 1.0 for immediate.
