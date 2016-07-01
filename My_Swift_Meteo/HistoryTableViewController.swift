//
//  HistoryViewController.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 28/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

  var history = Array<String>()
  var city: String = ""
  var weatherManager: WeatherManager!
  typealias Weather = WeatherManager.WeatherType
  
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherManager = WeatherManager(apiKey: "d38bcc15234a2813634decf8330571a5")
    history = HistoryManager.getSearchHistory()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel?.text = history[indexPath.row] as String
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let indexPath = tableView.indexPathForSelectedRow
    self.city = history[(indexPath?.row)!]
    self.performSegueWithIdentifier("weatherByHistory", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      if identifier == "weatherByHistory" {
        weatherManager.getWeatherDataFor(self.city) { (data) in
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
