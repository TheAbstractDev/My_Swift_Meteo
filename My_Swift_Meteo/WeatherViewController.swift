//
//  WeatherViewController.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 28/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var descrLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

}
