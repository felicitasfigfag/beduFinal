//
//  GreenViewController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 02/11/2021.
//

import UIKit

class RegViewController: UIViewController {
//label
    @IBOutlet weak var regTitle: UILabel!
    @IBOutlet weak var regMailTitle: UILabel!
    @IBOutlet weak var regSocialLabel: UILabel!
// input
    
    @IBOutlet var viewRegister: UIView!
    @IBOutlet weak var regUserInput: UITextField!
//btns
    
    var counter: Int = 0
    var colorsCount: Int = 3
    @IBAction func signUpFacebook(_ sender: Any) {
        
        let color: String = "Color"
        let colorName: String = color+"\(counter)"
        counter += 1
        viewRegister.backgroundColor = UIColor(named: colorName)
        if counter > colorsCount{
            counter = 1
        }
        
    }
    @IBAction func RegBtn(_ sender: Any) {
        goToMainController()
    }
    
    @IBAction func dismiss(_ sender: Any) {
       dismiss(animated: true, completion: nil)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
      
        view.insertSubview(backgroundImage, at: 0) // 2
        // Do any additional setup after loading the view.
    }
    func goToMainController(){
        performSegue(withIdentifier: "regGoToTab", sender: self)
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "goToTab") as? TabBarController
//       vc?.modalPresentationStyle = .fullScreen
//
//        guard let vc = vc else {return}
//        present(vc, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
