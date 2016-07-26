//
//  WeatherViewController.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 28/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftyBeaver

class WeatherViewController: UIViewController {

  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var descrLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  let log = SwiftyBeaver.self
  let console = ConsoleDestination()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    console.detailOutput = false
    console.dateFormat = "HH:mm:ss"
    log.removeAllDestinations()
    log.addDestination(console)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func setBackground(weatherType: WeatherManager.WeatherType, isDay: Int) {
    if isDay == 1 {
      switch weatherType {
      case .Clear:
        let colors:[UIColor] = [
          HexColor("A0D9FA"),
          HexColor("5FB9ED")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Cloudy:
        let colors:[UIColor] = [
          HexColor("C6D3DB"),
          HexColor("5FB9ED")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Drizzle:
        let colors:[UIColor] = [
          HexColor("C6D3DB"),
          HexColor("87A9BC")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Rainy:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Snowy:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Sunny:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("5FB9ED")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Thunderstorm:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Windy:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Haze:
        let colors:[UIColor] = [
          HexColor("C6D3DB"),
          HexColor("87A9BC")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      default:
        break
      }
    } else {
      switch weatherType {
      case .Clear:
        let colors:[UIColor] = [
          HexColor("102541"),
          HexColor("2E607C")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Cloudy:
        let colors:[UIColor] = [
          HexColor("C6D3DB"),
          HexColor("5FB9ED")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Drizzle:
        let colors:[UIColor] = [
          HexColor("C6D3DB"),
          HexColor("87A9BC")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Rainy:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Snowy:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Sunny:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("5FB9ED")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Thunderstorm:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Windy:
        let colors:[UIColor] = [
          HexColor("FEF29B"),
          HexColor("9BC9E4")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      case .Haze:
        let colors:[UIColor] = [
          HexColor("808B91"),
          HexColor("102541")
        ]
        view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: colors)
        break
      default:
        break
      }
    }
  }
}