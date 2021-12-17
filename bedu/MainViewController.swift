//
//  MainViewController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 02/11/2021.
//
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            let backgroundImage = UIImageView(image: UIImage(named: "background"))
          
            view.insertSubview(backgroundImage, at: 0) // 2
           
            
            let title = UILabel()
            title.text = "Temitas Player"
            title.font = UIFont(name: "Fractul-SemiBold", size: 40)
            title.textColor = .white
            title.autoresizingMask = .flexibleWidth
            title.translatesAutoresizingMaskIntoConstraints=true
            title.frame=CGRect(x: 0, y: 150, width: self.view.frame.width, height: 50)
            title.textAlignment = .center
            self.view.addSubview(title)
            
       
            
            var icono: UIImageView = {
                let imgView = UIImageView()
                imgView.contentMode = .scaleAspectFit
                imgView.image = UIImage(named: "ouroboros")
                imgView.translatesAutoresizingMaskIntoConstraints = true
                imgView.frame=CGRect(x: 100, y: 100, width: 300, height:300)

                return imgView
            }()
            self.view.addSubview(icono)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func logout(_sender: Any){
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagen.image = UIImage(systemName: "music.note.list")
    }
}

//2:16
