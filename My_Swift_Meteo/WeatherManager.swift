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
  
  private static var API_KEY: String? = nil
  internal static var lang: String? = nil
  
  public class func setAPIKEY(key: String) {
    self.API_KEY = key
  }
  
  public class func setLang(lang: String) {
    self.lang = lang
  }
  
  public class func getWeatherDataFor(city: String, completion: (JSON -> Void)) {
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

  public class func getWeatherDataFromGeographicCoordinates(latidute lat: Double, longitude lon: Double, completion: (JSON -> Void)) {
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