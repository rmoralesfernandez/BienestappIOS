//
//  ShowAppController.swift
//  Bienestapp
//
//  Created by alumnos on 03/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Alamofire
import AlamofireImage
import UIKit

class ShowAppController: UIViewController {
    
    var json: [String:Any]??
    var jsonUso:[[String:Any]]?
    
    var numberJson = 0
    
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var NombreApp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getApps()
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda1", for: indexPath) as! AppCelda
        
        if json != nil {
//            let url = URL(string: json![indexPath.row]["icon"] as! String)
//            cell.imageApp.af_setImage(withURL: url!)
//            cell.NameText.text = (json![indexPath.row]["name"]! as! String)
        }
        
        if jsonUso != nil {
            cell.tiempo.text = (jsonUso![indexPath.row]["totalTime"]! as! String)
        }
        
        return cell
    }
    
    func getApps() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrar")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [String:Any]
                let url = URL(string: self.json!!["icon"] as! String)
                self.imageApp.af_setImage(withURL: url!)
                self.NombreApp.text = self.json!!["name"] as! String
                //self.tableView.reloadData()
                
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

