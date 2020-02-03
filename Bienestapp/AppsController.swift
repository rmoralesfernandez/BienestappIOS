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

var apps_id: Int = 0

class AppsController: UITableViewController {
    
    var json: [[String:Any]]?
    var jsonUso:[[String:Any]]?
    
    var numberJson = 0
    override func viewWillAppear(_ animated: Bool) {
        
        getApps()
        getUsages()
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
        
        if json != nil {
            let url = URL(string: json![indexPath.row]["icon"] as! String)
            cell.imageApp.af_setImage(withURL: url!)
            cell.NameText.text = (json![indexPath.row]["name"]! as! String)
        }
        
        if jsonUso != nil {
            cell.TimeText.text = (jsonUso![indexPath.row]["totalTime"]! as! String)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: NSIndexPath) {
        apps_id = json![indexPath.row]["id"]! as! Int
        print(apps_id)
    }
    
    func getApps() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrar")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [[String: Any]]
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
    
    func getUsages() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrarUso")

        let header = ["Authentication": token]

        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                self.jsonUso = response.result.value as! [[String: Any]]
                for i in self.jsonUso! {
                    print(i["totalTime"]!)
                }
                
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
