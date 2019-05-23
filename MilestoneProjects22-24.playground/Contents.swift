import UIKit

// Challenge 1
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

let view = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
view.backgroundColor = .red
view.bounceOut(duration: 2)


// Challenge 2
extension Int {
    func times(closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 1...self {
            closure()
        }
    }
}
5.times { print("Hello!") }

// Challenge 3
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let itemIndex = firstIndex(of: item) {
            remove(at: itemIndex)
        }
    }
}

var numbers = [1, 2, 3, 4]
numbers.remove(item: 3)
