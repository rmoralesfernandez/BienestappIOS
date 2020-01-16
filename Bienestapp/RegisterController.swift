//
//  RegisterController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Alamofire
import UIKit

var user = User()

class RegisterController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func register(_ sender: Any) {
        if(!(nameTF.text!.isEmpty && emailTF.text!.isEmpty && passwordTF.text!.isEmpty)){
            user.name = nameTF.text!
            user.email = emailTF.text!
            user.password = passwordTF.text!
            postUser(user: user)
        }else{
            print("falta info")
        }
    }
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/register")
        let json = ["name": user.name,
                    "email": user.email,
                    "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }
    
    
    
    
}
