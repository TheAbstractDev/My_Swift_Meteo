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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    weatherManager = WeatherManager(apiKey: "d38bcc15234a2813634decf8330571a5", lang: "fr")
    LocationManager.configure()
  }
  
  @IBAction func locateMe(sender: AnyObject) {
    dispatch_async(dispatch_get_main_queue(), {
      self.performSegueWithIdentifier("weatherByLocation", sender: nil)
    })
  }

  @IBAction func search(sender: AnyObject) {
    HistoryManager.saveToSearchHistory(city: searchTextField.text!)
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
          }
        }
      }
      
      if identifier == "weatherBySearch" {
        if searchTextField.text != "" {
          weatherManager.getWeatherDataFor(self.searchTextField.text!) { (data) in
            let temp = data["main"]["temp"].intValue
            let city = data["name"].stringValue
            let descr = data["weather"][0]["description"].stringValue
            
            let nav = segue.destinationViewController
            let destinationVC = nav as! WeatherViewController
            destinationVC.cityLabel.text = city
            destinationVC.tempLabel.text = "\(temp)°C"
            destinationVC.descrLabel.text = descr
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
}

