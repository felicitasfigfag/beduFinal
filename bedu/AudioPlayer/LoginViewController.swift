//
//  ViewController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 31/10/2021.
// LOGIN

import UIKit

class LoginViewController: UIViewController {
   //labels
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    //inputs
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    
    //btns
    @IBAction func `continue`(_ sender: UIButton) {
        printFunction()
        let pass = self.password.text
        let email = self.user.text
        
//        c amiar por un guard let
//        touches began & view.end editing
        
        let resultPass = validatePassword(value: pass!)
       let resultEmail = validateEmail(email: email!)

        
        if user !== nil && password !== nil && resultPass == true {
            print("Puede pasar")
            goToMainController()
            
        }else if !resultPass{
            print("La contrasena debe tener 10 o mas caracteres")
        }
        else{
            print("Faltan datos")
        }}

    func goToMainController(){
        performSegue(withIdentifier: "goToTab", sender: self)

    }
    
    
    func printFunction(name: String = #function){
        print(name)
    }
    func validatePassword(value: String) -> Bool {
        return value.count > 10
    }
    func validateEmail(email: String) -> Bool {
       return email.contains("@")
           
       }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
      
        view.insertSubview(backgroundImage, at: 0) // 2
        
        
        // Do any additional setup after loading the view.
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }}

