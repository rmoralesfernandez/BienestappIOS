//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Alamofire
import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        if(emailTF.text!.isEmpty && passwordTF.text!.isEmpty){
            print("siuuuu")
            
        }else{
            print("buuuuu")
            user.email = emailTF.text!
            user.password = passwordTF.text!
            postUser(user: user)
        }
    }
    
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/login")
        let json = ["email": user.email,
                    "password": user.password]
        print(json)
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }


}

