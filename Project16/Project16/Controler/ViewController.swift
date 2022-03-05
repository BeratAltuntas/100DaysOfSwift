//
//  ViewController.swift
//  Project16
//
//  Created by BERAT ALTUNTAŞ on 5.03.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet var mapView: MKMapView!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D.init(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D.init(latitude: 59.95, longitude: 10.75), info: "Founded a thousand years ago.")
        let paris = Capital(title: "paris", coordinate: CLLocationCoordinate2D.init(latitude: 48.8567, longitude: 2.3508), info: "Often called City Of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D.init(latitude: 41.9, longitude: 12.5), info: "Has a hole country inside it.")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D.init(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself")
        let ankara = Capital(title: "Ankara", coordinate: CLLocationCoordinate2D(latitude: 39.92623816924362, longitude: 32.83630856248447), info: "Heart Of The Anatolia.")
        
        mapView.addAnnotations([london,oslo,paris,rome,washington,ankara])
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else{return nil}
        let identifier = "capital"
        
        var annotionView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotionView == nil{
            
            annotionView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
            annotionView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotionView?.rightCalloutAccessoryView = btn
        }else{
            annotionView?.annotation = annotation
        }
        return annotionView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else{return}
        
        let ac = UIAlertController(title: capital.title, message: capital.info , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
        
        
        
    }

}

