//
//  ViewController.swift
//  Project22
//
//  Created by Leandro Rocha on 5/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var regionReading: UILabel!
    @IBOutlet var circleView: UIView!
    
    var locationManager: CLLocationManager?
    
    var beaconsDetected = [String]()
    
    let myBeacons = [
        ("5A4BCFCE-174E-4BAC-A814-092E77F6B7E5", "MyBeacon1"),
        ("E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", "MyBeacon2"),
        ("74278BDA-B644-4520-8F0C-720EAF059935", "MyBeacon3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        circleView.layer.cornerRadius = 128
        circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        for (uuidString, identifier) in myBeacons {
            let uuid = UUID(uuidString: uuidString)!
            let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: identifier)
            
            locationManager?.startMonitoring(for: beaconRegion)
            locationManager?.startRangingBeacons(in: beaconRegion)
        }
    }
    
    func update(distance: CLProximity, in region: String) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceReading.text = "FAR"
                self.regionReading.text = "Region: \(region)"
                self.circleView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "NEAR"
                self.regionReading.text = "Region: \(region)"
                self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
                self.regionReading.text = "Region: \(region)"
                self.circleView.transform = CGAffineTransform(scaleX: 1, y: 1)
            default:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNKNOWN"
                self.regionReading.text = "Region: Unknown"
                self.circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if !beaconsDetected.contains(region.identifier) {
                beaconsDetected.append(region.identifier)
                let ac = UIAlertController(title: "Newly detected beacon: \(region.identifier)", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            update(distance: beacon.proximity, in: region.identifier)
        }
    }

}

