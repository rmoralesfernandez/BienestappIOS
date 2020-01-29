//
//  AppsController.swift
//  Bienestapp
//
//  Created by alumnos on 20/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Alamofire
import UIKit
import AlamofireImage

class AppsController: UITableViewController {
    
    var json: [[String:Any]]?
    
    var numberJson = 0
    override func viewWillAppear(_ animated: Bool) {
        
        getUser()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberJson
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! tableCell
        
        if json != nil{
            let url = URL(string: json![indexPath.row]["icon"] as! String)
            cell.imageApp.af_setImage(withURL: url!)
            cell.NameText.text = (json![indexPath.row]["name"]! as! String)
            print(indexPath.row)
            print(json![indexPath.row]["name"]!)
        }
        
        return cell
    }
    
    func getUser() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrar")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [[String: Any]]
                print(self.json![0]["name"])
                self.numberJson = self.json!.count
                self.tableView.reloadData()
                
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
