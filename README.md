# 100 Days of Swift
Projects with challenge solutions from my journey through [Paul Hudson's](https://www.twitter.com/twostraws) [100 Days Of Swift challenge](https://www.hackingwithswift.com/100).

## [Project 1](./Project1) - Storm Viewer

An app that shows a list of image names and displays the selected image in a new view controller.

- Table Views
- Image Views
- App Bundle
- File Manager
- Typecasting
- View Controllers
- Storyboards
- Outlets
- Auto Layout

## [Project 2](./Project2) - Guess the Flag

A game that displays three random flags and asks players to select the one that belongs to a particular country.

- Asset Catalog
- `UIButton`
- `CALayer`
- `UIColor`
- Random Numbers
- Actions
- `UIAlertController`

## [Project 3](./Project3) - Social Media

A technique project that allows users to share images with their friends.

- `UIBarButtonItem`
- `UIActivityViewController`
- Info.plist

## [Milestone Challenge](./MilestoneProjects1-3): Projects 1-3

An app that lists various world flags in a table view. When a row is tapped, a detail view controller displays the selected flag full size. Users have the ability to share the flag picture and country name.

## [Project 4](./Project4) - Easy Browser

A simple web browser app with restrictions to where the users can navigate.

- `WKWebView`
- `UIToolbar`
- `UIProgressView`
- Delegation
- KVO (Key-value observing)
- Creating views programmatically

## [Project 5](./Project5) - Word Scramble

A word game that deals with anagrams.

- Capture lists
- `UITextField`
- `NSRange`
- `UITextChecker`

## [Project 6a](./Project6a) - Auto Layout

A technique project covering Auto Layout. Part A is a copy of [project 2](./Project2) that uses Auto Layout.

- Creating Auto Layout constraints in Interface Builder

## [Project 6b](./Project6b) - Auto Layout

A technique project covering Auto Layout. Part B covers adding Auto Layout constraints in code.

- VFL (Visual Format Language)
- Layout Anchors

## [Milestone Challenge](./MilestoneProjects4-6): Projects 4-6

An app that allows users to create a shopping list. Items are added using an alert controller with a text field, and the entire list is shown in a table view.

## [Project 7](./Project7) - White House Petitions

An app that parses White House petitions. Data comes from the We the People API of the White House.

- `Data`
- `Codable`
- `UITabBarController`
- `UIStoryboard`

## [Project 8](./Project8) - 7 Swifty Words

A word-guessing game where players see a list of hints and an array of buttons with different letters on them, and need to use those buttons to enter words matching the hints.

- Creating UI in code
- Text alignment
- Layout margins
- `UIFont`

## [Project 9](./Project9) - Grand Central Dispatch

A technique project that solves the problem in [project 7](./Project7) of the UI being locked up until all data is transferred.

- `DispatchQueue`
- `performSelector()`

## [Milestone Challenge](./MilestoneProjects7-9): Projects 7-9

A hangman game. The user makes one guess at a time and if the guess is correct, the letter they guessed will be shown in the word. If they guess 7 times incorrectly, they lose.

## [Project 10](./Project10) - Names to Faces

An app that lets users put names to faces.

- `UICollectionViewController`
- `UICollectionView`
- `UICollectionViewCell`
- `UIImagePickerController`
- `NSObject`
- `Data`
- `UUID`
- `fatalError()`

## [Project 11](./Project11) - Pachinko

A `SpriteKit` game similar to Pachinko.

- `SKSpriteNode`
- `SKPhysicsBody`
- `SKPhysicsContactDelegate`
- `SKAction`
- `SKLabelNode`
- `SKEmitterNode`
- `UITouch`

## [Project 12](./Project12) - User Defaults

A technique project on `UserDefaults`. [Part A](./Project12a) demonstrates `NSCoding`. [Part B](./Project12b) demonstrates `Codable`.

- `UserDefaults`
- `NSCoding`
- `NSKeyedArchiver`
- `NSKeyedUnarchiver`
- `Codable`
- `JSONEncoder`
- `JSONDecoder`

## [Milestone Challenge](./MilestoneProjects10-12): Projects 10-12

An app that lets users take photos and add captions to them, and then displays the photos in a table view. Tapping on a caption will display the picture in a new view controller. Photos are stored and then loaded on app launch.

## [Project 13](./Project13) - Instafilter

An app that lets users apply Core Image filters to pictures from their photo library and save those images back to their photo library.

- Core Image
- `CIContext`
- `CIFilter`
- `UISlider`
- `UIImagePickerController`
- `UIImageWriteToSavedPhotosAlbum()`

## [Project 14](./Project14) - Whack-a-Penguin

A whack-a-mole game that uses penguins.

- `SKCropNode`
- `SKTexture`
- `SKAction`
- GCD

## [Project 15](./Project15) - Animation

A technique project focusing on animation.

- Core Animation
- `animate(withDuration:)`
- `CGAffineTransform`
- `alpha`

## [Milestone Challenge](./MilestoneProjects13-15): Projects 13-15

An app that lists country names in a table view. When a country is selected, facts about the country are displayed.


## [Project 16](./Project16) - Capital Cities

An app that shows locations of capital cities around the world, and when one of them is tapped you can bring up more information.

- `MKMapView`
- `MKAnnotation`
- `MKPinAnnotationView`
- `MKMapViewDelegate`
- `CLLocationCoordinate2D`

## [Project 17](./Project17) - Space Race

A game about survival: the goal is to pilot a spaceship safely through a field of space junk. The longer you stay alive, the higher your score is.

- Pixel-perfect collision detection
- Advancing particle systems
- `Timer`
- `linearDamping`
- `angularDamping`

## [Project 18](./Project18) - Debugging

A technique project where we look at different ways to identify problems in our code.

- `print()`
- `assert()`
- Breakpoints
- View debugging

## [Milestone Challenge](./MilestoneProjects16-18): Projects 16-18

A SpriteKit shooting gallery game. There are three rows of targets that slide across from one side to the other. When the user taps a target, the target fades out and they are awarded points.

## [Project 19](./Project19) - JavaScript Injection

A Safari extension that lets users read the URL and page title they are currently visiting, and lets them type JavaScript and have it execute in Safari.

- Extensions
- `NSExtensionItem`
- `NSItemProvider`
- JavaScript
- `UITextView`
- `NotificationCenter`

## [Project 20](./Project20) - Fireworks Night

A SpriteKit game that lets players create fireworks displays using their fingers. Players need to touch or swipe fireworks of the same color, then shake their device to make them explode.

- `UIBezierPath`
- `SKAction.follow()`
- `for case let`
- Sprite color blending
- Detecting shake gestures

## [Project 21](./Project21) - Local Notifications

A technique project on local notifications. 

- `UNUserNotificationCenter`
- Requesting permission for notifications
- `UNMutableNotificationContent`
- `UNNotificationSound`
- Notification triggers
- `UNNotificationRequest`
- `UNNotificationAction`
- `UNNotificationCategory`

## [Milestone Challenge](./MilestoneProjects19-21): Projects 19-21

Recreate the iOS Notes app. Notes are saved and users are able to share notes.

## [Project 22](./Project22) - Detect-a-Beacon

An app that allows users to detect and range beacons.

- Core Location
- `CLLocationManager`
- `CLBeaconRegion`
- `CLProximity`

## [Project 23](./Project23) - Swifty Ninja

A Fruit Ninja-style game, where slicing penguins is good and slicing bombs is bad.

- `SKShapeNode`
- `CGPath`
- `touchesEnded()`
- `AVAudioPlayer`
- `CaseIterable`

## [Project 24](./Project24.playground) - Swift Strings

A technique project focusing on Swift strings.

- `contains()`
- `NSAttributedString`
- `NSMutableAttributedString`

## [Milestone Challenge](./MilestoneProjects22-24.playground): Projects 22-24

Implement three Swift language extensions:
- [x] Extend `UIView` so that it has a `bounceOut(duration:)` method that uses animation to scale its size down to 0.0001 over a specified number of seconds.
- [x] Extend `Int` with a `times()` method that runs a closure as many times as the number is high.
- [x] Extend `Array` so that it has a mutating `remove(item:)` method. If the item exists more than once, it should remove only the first instance it finds.
