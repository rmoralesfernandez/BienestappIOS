//
//  ChangePasswordController.swift
//  Bienestapp
//
//  Created by alumnos on 30/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Alamofire
import UIKit

class ChangePasswordController: UIViewController {
    
    

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
}
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func update(_ sender: Any) {
        if password.text!.isEmpty || repeatPassword.text!.isEmpty{
            print("hola")
        } else if password.text! == repeatPassword.text! {
            user.password = password.text!
            updatePassword(user: user)
            dismiss(animated: true, completion: nil)
        } else {
            print("adios")
        }
    }

    func updatePassword(user: User) {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/updatePassword")
        let header = ["Authentication": token]
        let json = ["new_password": user.password]
        print(json)
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response)
            if response.response!.statusCode == 201 {
                var jsonPost = response.result.value as! [String: AnyObject]
            } else {
                let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                    (error) in
                }
                let alert = UIAlertController(title: "Error", message:
                    "Informacion Incorrecta", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
