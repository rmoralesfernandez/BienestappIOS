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
    var jsonUso:[[String:Any]]?
    
    var numberJson = 0
    var url = URL(string: "")
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
            url = URL(string: json![indexPath.row]["icon"] as! String)
            cell.imageApp.af_setImage(withURL: url!)
            cell.NameText.text = (json![indexPath.row]["name"]! as! String)
        }
        
        if jsonUso != nil {
            cell.TimeText.text = (jsonUso![indexPath.row]["totalTime"]! as! String)
            cell.dateText.text = (jsonUso![indexPath.row]["day"]! as! String)
            cell.dateText.isHidden = true
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let netScreen = segue.destination as! ShowAppController
        let cell = sender as! tableCell
        let nombre = cell.NameText.text!
        let imagenn = cell.imageApp.image!
        let date = cell.dateText.text!
        let time = cell.TimeText.text!
        netScreen.date = date
        netScreen.time = time
        netScreen.nombre = nombre
        netScreen.imagen = imagenn
        //print(imagenn)
        //print("Estefaniaa",netScreen.NombreApp!)
        
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
