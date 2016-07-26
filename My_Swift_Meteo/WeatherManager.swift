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
  
  private var API_KEY: String? = nil
  internal var lang: String? = nil
  internal var BASE_URL = "http://api.apixu.com/v1/current.json"
  
  public enum WeatherType {
    case Sunny
    case Rainy
    case Snowy
    case Windy
    case Cloudy
    case Clear
    case Drizzle
    case Thunderstorm
    case Haze
    case None
  }
  
  init (apiKey: String, lang: String? = nil) {
    self.API_KEY = apiKey
    if let lang = lang {
      setLang(lang)
    }
  }
  
  public func setLang(lang: String) {
    self.lang = lang
  }
  
  public func getWeatherDataFor(city: String, completion: (JSON -> Void)) {
    if self.API_KEY != nil {
      Alamofire.request(.GET, "\(BASE_URL)?key=\(self.API_KEY!)&q=\(city)").validate().responseJSON { response in
        switch response.result {
        case .Success:
          if let value = response.result.value {
            completion(JSON(value))
          }
        case .Failure(let error):
          completion(JSON(error))
        }
      }
    } else {
      print("Error: Your API key is not defined")
    }
  }
  
  public func weatherCondition(weather: String) -> WeatherType {
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
    
    if weather.lowercaseString.rangeOfString("drizzle") != nil {
      return WeatherType.Drizzle
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