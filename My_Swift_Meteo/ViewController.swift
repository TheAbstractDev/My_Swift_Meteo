//
//  ViewController.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    WeatherManager.setAPIKEY("d38bcc15234a2813634decf8330571a5")
    WeatherManager.setLang("fr")
    LocationManager.getCurrentLocation()
//    WeatherManager.getWeatherDataFor("Paris") { (data) in
//      print(data)
//    }
//
  }
  
  @IBAction func locateMe(sender: AnyObject) {
    let currentLocation = LocationManager.getCurrentLocation()
    if currentLocation["latitude"] != nil && currentLocation["latitude"] != nil {
      WeatherManager.getWeatherDataFromGeographicCoordinates(latidute: currentLocation["latitude"]!, longitude: currentLocation["longitude"]!) { (data) in
        let temp = data["main"]["temp"].intValue
        let city = data["name"].stringValue
        let descr = data["weather"][0]["description"].stringValue
        print("\(city): \(descr.uppercaseFirst). Il fait actuellement \(temp)°C")
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension String {
  var first: String {
    return String(characters.prefix(1))
  }
  var last: String {
    return String(characters.suffix(1))
  }
  var uppercaseFirst: String {
    return first.uppercaseString + String(characters.dropFirst())
  }
}

