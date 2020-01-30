//
//  ProfileController.swift
//  Bienestapp
//
//  Created by alumnos on 28/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Alamofire
import UIKit
import UserNotifications

class ProfileController: UIViewController {
    
    var json: [String:Any]??
    
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getPerimission(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (autorizado, error) in
            // El booleano "autorizado" será true si el usuario a dicho que sí
            if autorizado {
                print("Permiso concedido")
            } else {
                print("Permiso denegado:", error?.localizedDescription)
            }
        }
        
    }
    
    
    func getUser() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrarUsuario")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [String:Any]
                self.name.text = self.json!!["name"] as! String
                
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
