//
//  RecoverController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Alamofire
import UIKit

class RecoverController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func recoverPassword(_ sender: Any) {
        if (!emailTF.text!.isEmpty) {
            print("todo correcto")
            user.email = emailTF.text!
            postUser(user: user)
        }else{
            print("EL campo no puede estar vacio")
        }
    }
    
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/recover_password")
        let json = ["email": user.email]
        print(json)
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }
    
    
}
