# JavaScript Injection

A Safari extension that lets users read the URL and page title they are currently visiting, and lets them type JavaScript and have it execute in Safari.

## Main Topics Covered

- Extensions
- `NSExtensionItem`
- `NSItemProvider`
- JavaScript
- `UITextView`
- `NotificationCenter`

## Challenges
- [x] Add a bar button item that lets users select from a handful of prewritten example scritpts, shown using a `UIAlertController`.
- [x] You're already receiving the URL of the site the user is on, so use `UserDefaults` to save the user's JavaScript for each site. You should convert the URL to a `URL` object in order to use its `host` property.
- [x] For something bigger, let users name their scripts, then select one to load using a `UITableView`.
