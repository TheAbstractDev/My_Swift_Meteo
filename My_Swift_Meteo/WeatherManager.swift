//
//  WeatherManager.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class WeatherManager {
  private static var BASE_URL = "http://10.34.1.217:4000"
  
  public enum WeatherType {
    case Sunny
    case Rainy
    case Snowy
    case Windy
    case Cloudy
    case Clear
    case Mist
    case Thunderstorm
    case Haze
    case None
  }
  
  public class func getWeatherDataFor(city: String, completion: (JSON -> Void)) {
    Alamofire.request(.GET, "\(BASE_URL)/weather?city=\(city)").validate().responseJSON { response in
      switch response.result {
      case .Success:
        if let value = response.result.value {
          completion(JSON(value))
        }
      case .Failure(let error):
        completion(JSON(error))
      }
    }
  }
  
  public class func weatherCondition(weather: String) -> WeatherType {
    if weather.lowercaseString.rangeOfString("cloud") != nil {
      return WeatherType.Cloudy
    }
    
    if weather.lowercaseString.rangeOfString("rain") != nil {
      return WeatherType.Rainy
    }
    
    if weather.lowercaseString.rangeOfString("thunderstorm") != nil {
      return WeatherType.Thunderstorm
    }
    
    if weather.lowercaseString.rangeOfString("snow") != nil {
      return WeatherType.Snowy
    }
    
    if weather.lowercaseString.rangeOfString("mist") != nil {
      return WeatherType.Mist
    }
    
    if weather.lowercaseString.rangeOfString("wind") != nil {
      return WeatherType.Windy
    }
    
    if weather.lowercaseString.rangeOfString("clear") != nil {
      return WeatherType.Clear
    }
    
    if weather.lowercaseString.rangeOfString("sun") != nil {
      return WeatherType.Sunny
    }
    
    if weather.lowercaseString.rangeOfString("haze") != nil {
      return WeatherType.Haze
    }
    return WeatherType.None
  }
}