//
//  FavoritesManager.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit

public class FavoritesManager {
  
  public class func saveCityToFavorites(city: String) {
    let favorites = SwiftyDefaults.objectForKey("favorites")
    var data = Array<String>()
    
    if favorites != nil {
      var data = favorites as! Array<String>
      data.append(city)
    } else {
      data.append(city)
    }
    
    SwiftyDefaults.saveObject(data, forKey: "favorites")
  }
  
  public class func getFavoritesCities() -> Array<String> {
    let favorites = SwiftyDefaults.objectForKey("favorites")
    var data = Array<String>()
    
    if favorites != nil {
      data = favorites as! Array<String>
      return data
    } else {
      return []
    }
  }
  
  public class func removeFromFavorites(city:String) {
    SwiftyDefaults.remove(city, forKey: "favorites")
  }
  
  public class func removeAll() {
    SwiftyDefaults.removeAllObjectsForKey("favorites")
  }
}