//
//  Extensions.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 15/12/2021.
//

import Foundation
import CoreData

extension UIViewController {
    func alertOk(title: String, message: String, action: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: {
            _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regExp = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$", options: [])
        let coincidencias = regExp.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        
        return coincidencias.count > 0 ? true : false
        
    }
}
extension UITextField {
    func errorAnimated() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.4/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10, -10]
        self.layer.add(animation, forKey: "shake")
    }
    
    func startInController() {
        self.alpha = 0
        UIView.animate(withDuration: 1, delay: 0.2, animations: {
            self.alpha = 1
        })
    }
}
