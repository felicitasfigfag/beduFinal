//
//  PlayButton.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 9/12/2021.
//

import UIKit

class MenuButton: UIButton {

    var icon: UIImage?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.tintColor = .black
    }
    
    
//    func setImage(icon: UIImage?) {
//        guard let icon = icon else { return }
//        self.icon = icon
//        self.setImage(icon, for: .normal)
//    }

    
    @objc func menuFunc(){
        print(#function)
    }
    
    
}
