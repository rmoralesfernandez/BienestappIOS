//
//  ProfileController.swift
//  Bienestapp
//
//  Created by alumnos on 28/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import UserNotifications

class ProfileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getPerimission(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (autorizado, error) in
            // El booleano "autorizado" será true si el usuario a dicho que sí
            if autorizado {
                print("Permiso concedido")
                self.showNotification()
            } else {
                print("Permiso denegado:", error?.localizedDescription)
            }
        }
        
    }
    
    func showNotification (){
        let contenido = UNMutableNotificationContent()
        contenido.title = "Notificación!"
        contenido.subtitle = "Algo ha pasado"
        contenido.body = "Explicación de lo que ha pasado"
        contenido.sound = UNNotificationSound.default
        contenido.badge = 3
        
        // Definir cuándo dentro de cuántos segundo se va a lanzar la notificación
        let disparador = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        // Metemos el contenido y el disparador en una petición con un identificador de notificación
        let peticion = UNNotificationRequest(identifier: "miNotificacion", content: contenido, trigger: disparador)
        
        // Añadimos la petición de notificación a la cola de notificaciones
        UNUserNotificationCenter.current().add(peticion) { (error) in
            // Controlamos si ha habido algún error
            if error != nil {
                print("Ha ocurrido un error:", error?.localizedDescription)
            }
        }
    }
}
