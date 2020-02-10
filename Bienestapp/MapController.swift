//
//  MapController.swift
//  Bienestapp
//
//  Created by alumnos on 23/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
import Alamofire
import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var jsonUso:[[String:Any]]?
    var locations: [[Float]] = []
    
    let manager = CLLocationManager()
    @IBOutlet weak var mapa: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsages()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        mapa.delegate = self
    }
    

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        pin()
        //indicaciones(localizacion: locations.first!)
    }
    
    func pin() {
        let localizacion = CLLocationCoordinate2DMake(40, -4)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        mapa.setRegion(region, animated: true)
        
        let anotacion = MKPointAnnotation()
        print(locations)
        for location in locations {
            anotacion.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location[0]), longitude: CLLocationDegrees(location[1]))
            anotacion.title = "Sitio"
            anotacion.subtitle = "Maravilloso"
            
            print(anotacion.title!)
            mapa.addAnnotation(anotacion)
        }  
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title!)
    }
    
    func getUsages() {
        let url = URL(string: "http://localhost:8888/Rick/BienestappRick/public/index.php/api/mostrarLocation")
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                self.jsonUso = response.result.value as! [[String: Any]]
                for i in self.jsonUso! {
                    let localizacion = i["location"]! as! String
                    var locationString = localizacion.split(separator: ",")
                    let locationFloat = [Float(locationString[0]),Float(locationString[1])]
                    self.locations.append (locationFloat as! [Float])
                    
                    
                    //print(locations[0])
                }
                self.pin()
               
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
