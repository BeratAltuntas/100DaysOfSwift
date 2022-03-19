//
//  ViewController.swift
//  Project22
//
//  Created by BERAT ALTUNTAŞ on 19.03.2022.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var labelLocation: UILabel!
    var locationManager : CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if manager.authorizationStatus == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    startScaning()
                }
            }
        }
    }
    
    func startScaning(){
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity){
        UIView.animate(withDuration: 1){
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.labelLocation.text = "FAR"
            case .near:
                self.view.backgroundColor = .orange
                self.labelLocation.text = "NEAR"
            case .immediate:
                self.view.backgroundColor = .green
                self.labelLocation.text = "RIGHT HERE"
            default:
                self.view.backgroundColor = .gray
                self.labelLocation.text = "UNKNOWN"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first{
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }
}

