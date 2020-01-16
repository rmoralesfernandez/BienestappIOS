//
//  RecoverController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class RecoverController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recoverPassword(_ sender: Any) {
        if (emailTF.text! == user.email) {
            print("todo correcto")
        }else{
            print("este email no coincide con uno existente")
        }
    }
    
    
}
