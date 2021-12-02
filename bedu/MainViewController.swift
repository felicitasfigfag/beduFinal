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
        // Do any additional setup after loading the view.
    }
    @IBAction func logout(_sender: Any){
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagen.image = UIImage(systemName:  "music.mic")
    }
}

//2:16
