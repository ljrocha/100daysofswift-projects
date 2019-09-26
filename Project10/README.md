# Names to Faces

An app that lets users put names to faces.

## Main Topics Covered

- `UICollectionViewController`
- `UICollectionView`
- `UICollectionViewCell`
- `UIImagePickerController`
- `NSObject`
- `Data`
- `UUID`
- `fatalError()`

## Challenges
- [x] Add a second `UIAlertController` that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.
- [x] Try using `picker.sourceType = .camera` when creating your image picker, which will tell it to create a new image by taking a photo. Because this is only available on devices (not the simulator), you might want to check the return value of `UIImagePickerController.isSourceTypeAvailable()` before trying to use it.
- [x] Modify [project 1](../Project10-Challenge3) so that it uses a collection view controller rather than a table view controller.
