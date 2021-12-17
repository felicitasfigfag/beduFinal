

import UIKit


public extension UILabel {
    static func makeAppLabel(_ color: UIColor, size: CGSize) -> UILabel {
        let labelExt = UILabel()
       
            //label1.font = UIFont.systemFont(ofSize: size)
        labelExt.textColor = color
            //label1.backgroundColor = UIColor(red:0.0, green: 1.0, blue: 0.5, alpha:0.75)
        labelExt.autoresizingMask = .flexibleWidth
        labelExt.translatesAutoresizingMaskIntoConstraints=true
            
        labelExt.textAlignment = .center
            
        return labelExt
    }
}
