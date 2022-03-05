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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(showMapTypes))
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D.init(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D.init(latitude: 59.95, longitude: 10.75), info: "Founded a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D.init(latitude: 48.8567, longitude: 2.3508), info: "Often called City Of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D.init(latitude: 41.9, longitude: 12.5), info: "Has a hole country inside it.")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D.init(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself")
        let ankara = Capital(title: "Ankara", coordinate: CLLocationCoordinate2D(latitude: 39.92623816924362, longitude: 32.83630856248447), info: "Heart Of The Anatolia.")
       
        mapView.addAnnotations([london,oslo,paris,rome,washington,ankara])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else{return nil}
        let identifier = "capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            let annotationView2 = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
            annotationView2.pinTintColor = .systemYellow
            annotationView2.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView2.rightCalloutAccessoryView = btn
            annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
            annotationView? = annotationView2
        }else{
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        title = view.annotation?.title!
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else{return}
        if let webViewController = storyboard?.instantiateViewController(withIdentifier: "Web") as? WebViewController{
            webViewController.capital = [capital.self]
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }

    
    @objc func showMapTypes(){
        let ac = UIAlertController(title: "Select Map Types", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Satellit Flyover", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Standart", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Muted Standart", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated:true)
    }
    
    func changeMapType(_ action:UIAlertAction){
        switch action.title{
        case "Satellite":
            mapView.mapType = .satellite
            break
        case "Satellit Flyover":
            mapView.mapType = .satelliteFlyover
            break
        case "Hybrid":
            mapView.mapType = .hybrid
            break
        case "Hybrid Flyover":
            mapView.mapType = .hybridFlyover
            break
        case "Standart":
            mapView.mapType = .standard
            break
        case "Muted Standart":
            mapView.mapType = .mutedStandard
            break
        default:
            return
        }
        
    }
}

