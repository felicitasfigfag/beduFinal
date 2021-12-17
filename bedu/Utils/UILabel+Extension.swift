

import UIKit


public extension UILabel {
    static func makeAppLabel(_ color: UIColor, size: CGSize) -> UILabel {
        let label1 = UILabel()
       
            //label1.font = UIFont.systemFont(ofSize: size)
            label1.textColor = color
            //label1.backgroundColor = UIColor(red:0.0, green: 1.0, blue: 0.5, alpha:0.75)
            label1.autoresizingMask = .flexibleWidth
            label1.translatesAutoresizingMaskIntoConstraints=true
            
            label1.textAlignment = .center
            
        return label1
    }
}
