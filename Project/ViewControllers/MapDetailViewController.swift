//
//  MapDetailViewController.swift
//  Project
//
//  Created by Macbook on 23/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MapDetailViewController: MasterViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var userSelected:Usuario?
    var employeeSelected:EmployeeStruct?
    
    var myLocation:CLLocation?
    var toLocation:CLLocation?
    
    @IBOutlet weak var txfTimeEstimated: UITextField!
    @IBOutlet weak var txfAddress: UITextField!
    @IBOutlet weak var txfAomunt: UITextField!
    @IBOutlet weak var personToVisit: UITextField!
    @IBOutlet weak var txfDelegacion: UITextField!
    @IBOutlet weak var txfCP: UITextField!
    @IBOutlet weak var txfTimeAprox: UITextField!
    @IBOutlet weak var txfNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        getGeocoder()
        
    }
    
    func getGeocoder(){
        let geocoder = CLGeocoder()
        
        let address =  self.employeeSelected!.address ?? ""
        print(address.replacingOccurrences(of: "-", with: "", options: .literal , range: nil))
     
        geocoder.geocodeAddressString(address.replacingOccurrences(of: "-", with: "", options: .literal , range: nil)){
            (placeMarks, error)
            in
            
            if error != nil{
                print(error ?? "")
                self.showAlert(titleS: "Rutas", messageS: "No se ha encontrado la dirección buscada favor de verificarla")
            }
            
            if let pm = placeMarks{
                print("placeMarks obtenidas \(pm.count)")
                self.txfAddress.text = self.employeeSelected?.address
                self.txfAomunt.text = self.userSelected?.amount
                self.personToVisit.text = self.employeeSelected?.fullName
                self.txfDelegacion.text = pm.first?.subLocality
                self.txfCP.text = pm.first?.postalCode
                self.toLocation = pm.first?.location
                self.myLocation = CLLocation(latitude:19.4336, longitude:-99.1454)
                self.traceWay()
            }
            
        }
    }
    
    
    func traceWay(){
        let directionRequest = MKDirections.Request()
        
        let sourcePlacemark = MKPlacemark.init(coordinate: (myLocation?.coordinate)!)
        let sourceMapItem = MKMapItem.init(placemark: sourcePlacemark)
        
        let destinationPlacemark = MKPlacemark.init(coordinate: (toLocation?.coordinate)!)
        let destinationMapItem = MKMapItem.init(placemark: destinationPlacemark)
        
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        directionRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            print(response.routes.count)
            self.txfTimeEstimated.text = "\(route.distance / 1000) Km."
            self.txfTimeAprox.text = "\(route.expectedTravelTime / 60 ) min."
            self.title = route.name
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        
        let center = CLLocationCoordinate2D(latitude: (myLocation?.coordinate.latitude)! , longitude: (myLocation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta:  0.005))
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        self.mapView.showsCompass = true
    }
    

}




extension MapDetailViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        print(location.coordinate)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Existe un error al recuperar los datos de la ubicación")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("El usuario a autorizado por siempre")
        case .authorizedWhenInUse:
            print("El usuario a autorizado solo cuando esta en uso")
        case .denied:
            print("El permiso no se ha concedido")
        case .restricted:
            print("Restingido")
        case .notDetermined:
            print("No determinado")
        default:
            print("Nothing")
        }
    }
    
}

extension MapDetailViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.lineDashPattern = [2,4];
        renderer.lineWidth = 4.0
        renderer.alpha = 1
        return renderer
    }
    
}
