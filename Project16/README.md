# Capital Cities

An app that shows locations of capital cities around the world, and when one of them is tapped you can bring up more information.

## Main Topics Covered

- `MKMapView`
- `MKAnnotation`
- `MKPinAnnotationView`
- `MKMapViewDelegate`
- `CLLocationCoordinate2D`

## Challenges
- [x] Try typecasting the return value from `dequeueReusableAnnotationView()` so that it's an `MKPinAnnotationView`. Once that's done, change the `pinTintColor` property to your favorite `UIColor`.
- [x] Add a `UIAlertController` that lets users specify how they want to view the map. There's a `mapType` property that draws the maps in different ways.
- [x] Modify the callout button so that pressing it shows a new view controller with a web view, taking users to the Wikipedia entry for that city.
