//
//  TodayViewController.swift
//  My_Swift_Meteo_Extension
//
//  Created by Sofiane Beors on 12/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UITableViewController, NCWidgetProviding {
  
  let favorites = FavoritesManager.getFavoritesCities()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("lol")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel?.text = favorites[indexPath.row] as String
    return cell
  }
  
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
    completionHandler(NCUpdateResult.NewData)
  }
  
}
