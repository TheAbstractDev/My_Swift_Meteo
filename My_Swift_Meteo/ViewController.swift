//
//  ViewController.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var searchTextField: UITextField!
  var weatherManager: WeatherManager!
  typealias Weather = WeatherManager.WeatherType
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    weatherManager = WeatherManager(apiKey: "d38bcc15234a2813634decf8330571a5")
    LocationManager.configure()
  }
  
  @IBAction func locateMe(sender: AnyObject) {
    dispatch_async(dispatch_get_main_queue(), {
      self.performSegueWithIdentifier("weatherByLocation", sender: nil)
    })
  }

  @IBAction func search(sender: AnyObject) {
    HistoryManager.saveToSearchHistory(city: searchTextField.text!.replace(" ", by: "-"))
    dispatch_async(dispatch_get_main_queue(), {
      self.performSegueWithIdentifier("weatherBySearch", sender: nil)
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      if identifier == "weatherByLocation" {
        let currentLocation = LocationManager.getCurrentLocation()
        
        if currentLocation["latitude"] != nil && currentLocation["latitude"] != nil && currentLocation["cityName"] != nil {
          weatherManager.getWeatherDataFromGeographicCoordinates(latidute: Double(currentLocation["latitude"]!.stringValue)!, longitude: Double(currentLocation["longitude"]!.stringValue)!) { (data) in
            let temp = data["main"]["temp"].intValue
            let city = currentLocation["cityName"]! as! String
            let descr = data["weather"][0]["description"].stringValue
            
            let nav = segue.destinationViewController
            let destinationVC = nav as! WeatherViewController
            destinationVC.cityLabel.text = city
            destinationVC.tempLabel.text = "\(temp)°C"
            destinationVC.descrLabel.text = descr
            
            if descr.rangeOfString("clouds") != nil {
              destinationVC.setBackground(Weather.Cloudy)
            }
            
            if descr.rangeOfString("rain") != nil {
              destinationVC.setBackground(Weather.Rainy)
            }
            
            if descr.rangeOfString("thunderstorm") != nil {
              destinationVC.setBackground(Weather.Thunderstorm)
            }
            
            if descr.rangeOfString("snow") != nil {
              destinationVC.setBackground(Weather.Snowy)
            }
            
            if descr.rangeOfString("drizzle") != nil {
              destinationVC.setBackground(Weather.Drizzle)
            }
            
            if descr.rangeOfString("wind") != nil {
              destinationVC.setBackground(Weather.Windy)
            }
            
            if descr.rangeOfString("clear") != nil {
              destinationVC.setBackground(Weather.Clear)
            }
            
            if descr.rangeOfString("sun") != nil {
              destinationVC.setBackground(Weather.Sunny)
            }
            
            if descr.rangeOfString("haze") != nil {
              destinationVC.setBackground(Weather.Haze)
            }
          }
        }
      }
      
      if identifier == "weatherBySearch" {
        if searchTextField.text != "" {
          let cityWithDash = self.searchTextField.text!.replace(" ", by: "-")
          
          weatherManager.getWeatherDataFor(cityWithDash) { (data) in
            let temp = data["main"]["temp"].intValue
            let city = data["name"].stringValue
            let descr = data["weather"][0]["description"].stringValue
            
            let nav = segue.destinationViewController
            let destinationVC = nav as! WeatherViewController
            destinationVC.cityLabel.text = city
            destinationVC.tempLabel.text = "\(temp)°C"
            destinationVC.descrLabel.text = descr
            
            if descr.rangeOfString("clouds") != nil {
              destinationVC.setBackground(Weather.Cloudy)
            }
            
            if descr.rangeOfString("rain") != nil {
              destinationVC.setBackground(Weather.Rainy)
            }
            
            if descr.rangeOfString("thunderstorm") != nil {
              destinationVC.setBackground(Weather.Thunderstorm)
            }
            
            if descr.rangeOfString("snow") != nil {
              destinationVC.setBackground(Weather.Snowy)
            }
            
            if descr.rangeOfString("drizzle") != nil {
              destinationVC.setBackground(Weather.Drizzle)
            }
            
            if descr.rangeOfString("wind") != nil {
              destinationVC.setBackground(Weather.Windy)
            }
            
            if descr.rangeOfString("clear") != nil {
              destinationVC.setBackground(Weather.Clear)
            }
            
            if descr.rangeOfString("sun") != nil {
              destinationVC.setBackground(Weather.Sunny)
            }
            
            if descr.rangeOfString("haze") != nil {
              destinationVC.setBackground(Weather.Haze)
            }
          }
        }
      }
    }
  }
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
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
  
  func replace(character: String, by: String) -> String {
    return self.stringByReplacingOccurrencesOfString(character, withString: by)
  }
}

