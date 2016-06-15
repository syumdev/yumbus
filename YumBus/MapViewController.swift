//
//  SecondViewController.swift
//  YumBus
//
//  Created by Seungheon Yum on 5/28/16.
//  Copyright © 2016 syumdev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var _mapView: MKMapView!

    let locationManager = CLLocationManager()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    let regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            print("here?")
            locationManager.startUpdatingLocation()
            print("and here")
        }
        
        print(self.locationManager.location)
        
        
    }
    

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("but never here")
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
    
        
        let initialLocation = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        _mapView.centerCoordinate = initialLocation
        locationManager.stopUpdatingLocation()
        let centerLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        centerMapOnLocation(centerLocation)
        let pin = MKPointAnnotation()
        pin.coordinate = initialLocation
        pin.title="Apple HQ"
        _mapView.addAnnotation(pin)
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        _mapView.setRegion(coordinateRegion, animated: true)
    }

}