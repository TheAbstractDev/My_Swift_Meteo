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
          WeatherManager.getWeatherDataFor(currentLocation["cityName"] as! String) { (data) in
            if data.count > 0 {
              let temp = data["temperature_c"].stringValue
              let city = data["city"].stringValue
              let country = data["country"].stringValue
              let descr = data["description"].stringValue
              let isDay = data["is_day"].stringValue
              let feelsLike = data["feels_like_c"].stringValue
              let iconUrl = data["icon_url"].stringValue
              let humidiy = data["humidity"].stringValue
              
              let nav = segue.destinationViewController
              let destinationVC = nav as! WeatherViewController
              destinationVC.cityLabel.text = city
              destinationVC.countryLabel.text = country
              destinationVC.imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: iconUrl)!)!)
              destinationVC.feelsLikeLabel.text = "\(feelsLike)°C"
              destinationVC.humidityLabel.text = "\(humidiy)%"
              destinationVC.tempLabel.text = "\(temp)°C"
              destinationVC.descrLabel.text = descr
              destinationVC.setBackground(WeatherManager.weatherCondition(descr), isDay: isDay)
            } else {
              let alertCtlr = UIAlertController(title: "Erreur", message: "Aucunes données trouvés. Réessayez avec une autre ville / orthographe.", preferredStyle: UIAlertControllerStyle.Alert)
              alertCtlr.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
              self.presentViewController(alertCtlr, animated: true, completion: nil)
            }
          }
        }
      }
      
      if identifier == "weatherBySearch" {
        if searchTextField.text != "" {
          var city = self.searchTextField.text!.replace(" ", by: "-")
          city = city.replace("é", by: "e")
          
          WeatherManager.getWeatherDataFor(city) { (data) in
            if data.count > 0 {
              let temp = data["temperature_c"].stringValue
              let city = data["city"].stringValue
              let country = data["country"].stringValue
              let descr = data["description"].stringValue
              let isDay = data["is_day"].stringValue
              let feelsLike = data["feels_like_c"].stringValue
              let iconUrl = data["icon_url"].stringValue
              let humidiy = data["humidity"].stringValue
              
              let nav = segue.destinationViewController
              let destinationVC = nav as! WeatherViewController
              destinationVC.cityLabel.text = city
              destinationVC.countryLabel.text = country
              destinationVC.imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: iconUrl)!)!)
              destinationVC.feelsLikeLabel.text = "\(feelsLike)°C"
              destinationVC.humidityLabel.text = "\(humidiy)%"
              destinationVC.tempLabel.text = "\(temp)°C"
              destinationVC.descrLabel.text = descr
              destinationVC.setBackground(WeatherManager.weatherCondition(descr), isDay: isDay)
            } else {
              let alertCtlr = UIAlertController(title: "Erreur", message: "Aucunes données trouvés. Réessayez avec une autre ville / orthographe.", preferredStyle: UIAlertControllerStyle.Alert)
              alertCtlr.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
              self.presentViewController(alertCtlr, animated: true, completion: nil)
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

