//
//  AppsController.swift
//  Bienestapp
//
//  Created by alumnos on 20/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Alamofire
import UIKit

class AppsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUser()
}
    
    func getUser() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrar")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.response!.statusCode == 201 {
                let json = response.result.value as! [[String: Any]]
                for i in json {
                    print(i["name"]!)
                }
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
