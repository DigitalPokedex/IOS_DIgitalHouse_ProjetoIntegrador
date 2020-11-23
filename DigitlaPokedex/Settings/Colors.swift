import UIKit
import Foundation

enum Colors {
    static let primary = UIColor(rgb: 0x89A6D6)
    static let grey = UIColor(rgb: 0x000000).withAlphaComponent(0.05)
}
// Usage Examples:
//   - let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
//   - let color2 = UIColor(rgb: 0xFFFFFF)
//   - let semitransparentBlack = UIColor(rgb: 0x000000).withAlphaComponent(0.5)
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")
       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
