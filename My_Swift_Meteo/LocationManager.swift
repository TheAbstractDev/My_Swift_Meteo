//
//  LocationManager.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit
import CoreLocation

public class LocationManager: NSObject, CLLocationManagerDelegate {
  
  public static let sharedInstance = LocationManager()
  private let locationManager = CLLocationManager()
  
  private var currentPosition = [String: AnyObject]()
  public var locationServiceIsEnabled: Bool!

  override init () {
    super.init()
    if CLLocationManager.locationServicesEnabled() {
      locationServiceIsEnabled = true
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
    } else {
      self.locationServiceIsEnabled = false
    }
  }
  
  public class func configure() {
    getCurrentLocation()
  }
  
  public class func getCurrentLocation() -> [String: AnyObject] {
    return self.sharedInstance.currentPosition
  }
  
  @objc public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.locationManager.stopUpdatingLocation()
    let location: CLLocationCoordinate2D = manager.location!.coordinate
    CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placemarks, error) in
      if placemarks?.count > 0 {
        self.currentPosition = [
          "latitude": location.latitude,
          "longitude": location.longitude,
          "cityName": placemarks![0].locality!
        ]
      }
    }
  }
}