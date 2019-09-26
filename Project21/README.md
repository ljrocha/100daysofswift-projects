# Local Notifications

A technique project on local notifications. 

## Main Topics Covered

- `UNUserNotificationCenter`
- Requesting permission for notifications
- `UNMutableNotificationContent`
- `UNNotificationSound`
- Notification triggers
- `UNNotificationRequest`
- `UNNotificationAction`
- `UNNotificationCategory`

## Challenges
- [x] Update the code in `didReceive` so that it shows different instances of `UIAlertController` depending on which action identifier was passed in.
- [x] Add a second `UNNotificationAction` to the `alarm` category. Give it the title "Remind me later", and make it call `scheduleLocal()` so that the same alert is shown in 24 hours. (For the purposes of these challenges, a time interval notification with 86400 seconds is good enough.)
- [x] Update [project 2](../Project2) so that it reminds players to come back and play every day.
