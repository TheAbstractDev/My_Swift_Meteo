//
//  WeatherManager.swift
//  My_Swift_Meteo_Server
//
//  Created by Sofiane Beors on 26/07/2016.
//  Copyright © 2016 Crossroad Labs. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SwiftyBeaver

public class WeatherManager {
  private var API_KEY: String? = nil
  private var BASE_URL = "http://api.apixu.com/v1/current.json"
    
  init (apiKey: String) {
    self.API_KEY = apiKey
  }
    
  public func weatherData(city: String, completion: (Dictionary<String, String> -> Void)) {
    if self.API_KEY != nil {
      Alamofire.request(.GET, "\(BASE_URL)?key=\(self.API_KEY!)&q=\(city)").validate().responseJSON { response in
        switch response.result {
        case .Success:
          if let value = response.result.value {
            let json = JSON(value)
            completion([
              "city": json["location"]["name"].stringValue,
              "temperature": json["current"]["temp_c"].stringValue,
              "description": json["current"]["condition"]["text"].stringValue,
              "is_day": json["current"]["is_day"].stringValue
            ])
          }
        case .Failure(let error):
          let err = JSON(error)
          completion([
            "error": err["message"].stringValue
          ])
        }
      }
    } else {
      print("Error: Your API key is not defined")
    }
  }
}