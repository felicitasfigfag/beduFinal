//
//  RegisterViewController.swift
//  MyApp
//
//  Created by Jan Zelaznog on 10/10/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var tipoError:Int = 0
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var btn_facebook: UIButton!
    
    @IBAction func facebook(_ sender: Any) {
        btn_facebook.backgroundColor = UIColor(named: "MainColor")
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func register(_ sender: Any) {
        guard let username = username.text
        else {
            //self.username.errorAnimated()
            print ("no se puede continuar")
            return
        }
        if username != "" {
            if !username.isValidEmail() {
                //self.username.errorAnimated()
                
                //self.showSimpleAlert("el nombre de usuario debe ser un correo válido")
                tipoError = 2
                
            }
        }
        else {
            //self.username.errorAnimated()
            //self.showSimpleAlert("el nombre de usuario no puede estar vacío")
            tipoError = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "AccentColor")
        label1.textColor = UIColor(named: "MainColor")
        label2.textColor = UIColor(named: "MainColor")
        label3.textColor = UIColor(named: "MainColor")
        // Do any additional setup after loading the view.
    }
    

}
