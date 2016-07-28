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
  typealias Weather = WeatherManager.WeatherType
  
  override func viewDidLoad() {
    super.viewDidLoad()
    history = HistoryManager.removeAll()
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
        WeatherManager.getWeatherDataFor(self.city) { (data) in
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
