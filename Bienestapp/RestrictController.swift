//
//  Restrict.swift
//  Bienestapp
//
//  Created by alumnos on 23/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

var restriction = Restriction()

class RestrictController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var json: [[String:Any]]?
    var numberJson = 0
    var SelectedApp = ""
    
    @IBOutlet weak var EndTime: UIDatePicker!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var slidertime: UISlider!
    @IBOutlet weak var StartTime: UIDatePicker!
    @IBOutlet weak var AppSelect: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.AppSelect.delegate = self
        self.AppSelect.dataSource = self
        getApps()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberJson
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        SelectedApp = json![row]["name"]! as! String
        return SelectedApp
    }
    
    
    @IBAction func AddRestrict(_ sender: Any) {
        let maxTime = self.slidertime!.value as! Float
        let integer: Int = Int(maxTime)
    
        restriction.name = SelectedApp
        print(restriction.name)
        restriction.max_time = String(integer)
        
         let start = StartTime.date
        let formateador = DateFormatter()
        formateador.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let startTexto = formateador.string(from: start)
        
        var finish = EndTime.date
        finish = checkDates(StartTime: start, EndTime: finish)
        let EndTexto = formateador.string(from: finish)
        
        restriction.start_hour = startTexto
        restriction.finish_hour = EndTexto
        
        postRestriction(restriction: restriction)
        print(restriction.start_hour)
        
    }
    
    
    @IBAction func sliderInfo(_ sender: Any) {
        self.sliderValue.text = "\(self.slidertime.value)"
    }
    
    func checkDates (StartTime: Date, EndTime: Date) -> Date{
        if StartTime >= EndTime {
            let newFinish = EndTime + 86400
            return newFinish
        }
        
        return EndTime
    }
    
    func postRestriction (restriction: Restriction) {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/restriction")
        
        let header = ["Authentication": token]
        let json = ["name": restriction.name, "max_time": restriction.max_time, "start_hour_restriction": restriction.start_hour, "finish_hour_restriction": restriction.finish_hour] as [String: Any]
        
        print(json)
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response?.statusCode)
        }
    }
    
    func getApps() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrar")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(self.numberJson)

            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [[String: Any]]
                self.numberJson = self.json!.count
                self.AppSelect.reloadAllComponents()
                print(self.numberJson)
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
