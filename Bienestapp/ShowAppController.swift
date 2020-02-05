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
    
    var nombre: String = ""
    var imagen: UIImage? = nil
    var time: String = ""
    var date: String = ""
    
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var NombreApp: UILabel!
    @IBOutlet weak var dateApp: UILabel!
    @IBOutlet weak var timeApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NombreApp.text! = nombre
        imageApp.image = imagen
        dateApp.text! = date
        timeApp.text! = time
    }
    
    @IBAction func atras(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    

}

