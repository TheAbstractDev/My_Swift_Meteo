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
      Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&APPID=\(self.API_KEY!)&lang=\(lang ?? "en")").validate().responseJSON { response in
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

  public func getWeatherDataFromGeographicCoordinates(latidute lat: Double, longitude lon: Double, completion: (JSON -> Void)) {
    if self.API_KEY != nil {
      Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&APPID=\(self.API_KEY!)&lang=\(lang ?? "en")").validate().responseJSON { response in
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
}