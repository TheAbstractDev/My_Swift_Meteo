//
//  ViewController.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit
import SwiftyBeaver

class ViewController: UIViewController {

  @IBOutlet weak var searchTextField: UITextField!
  var weatherManager: WeatherManager!
  typealias Weather = WeatherManager.WeatherType
  let log = SwiftyBeaver.self
  let console = ConsoleDestination()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    console.detailOutput = false
    console.dateFormat = "HH:mm:ss"
    log.removeAllDestinations()
    log.addDestination(console)
    self.hideKeyboardWhenTappedAround()
    weatherManager = WeatherManager(apiKey: "650e2a6cd7d34c84905105743162507")
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
        if currentLocation["cityName"] != nil {
          weatherManager.getWeatherDataFor(currentLocation["cityName"] as! String) { (data) in
            let temp = data["current"]["temp_c"].intValue
            let city = data["location"]["name"].stringValue
            let descr = data["current"]["condition"]["text"].stringValue
            let isDay = data["current"]["is_day"].intValue
            
            let nav = segue.destinationViewController
            let destinationVC = nav as! WeatherViewController
            destinationVC.cityLabel.text = city
            destinationVC.tempLabel.text = "\(temp)°C"
            destinationVC.descrLabel.text = descr
            destinationVC.setBackground(self.weatherManager.weatherCondition(descr), isDay: isDay)
          }
        }
      }
      
      if identifier == "weatherBySearch" {
        if searchTextField.text != "" {
          var city = self.searchTextField.text!.replace(" ", by: "-")
          city = city.replace("é", by: "e")
          
          weatherManager.getWeatherDataFor(city) { (data) in
            let temp = data["current"]["temp_c"].intValue
            let city = data["location"]["name"].stringValue
            let descr = data["current"]["condition"]["text"].stringValue
            let isDay = data["current"]["is_day"].intValue
            
            let nav = segue.destinationViewController
            let destinationVC = nav as! WeatherViewController
            destinationVC.cityLabel.text = city
            destinationVC.tempLabel.text = "\(temp)°C"
            destinationVC.descrLabel.text = descr
            destinationVC.setBackground(self.weatherManager.weatherCondition(descr), isDay: isDay)
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

