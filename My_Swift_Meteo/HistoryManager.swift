//
//  HistoryManager.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 09/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import UIKit

public class HistoryManager {

  public class func saveToSearchHistory(city c: String) {
    let history = SwiftyDefaults.objectForKey("history")
    var data = Array<String>()
    
    if history != nil {
      data = history as! Array<String>
      data.append(c)
    } else {
      data.append(c)
    }
    
    SwiftyDefaults.saveObject(data, forKey: "history")
  }

  public class func getSearchHistory() -> Array<String> {
    let history = SwiftyDefaults.objectForKey("history")
    var data = Array<String>()
    
    if history != nil {
      data = history as! Array<String>
      return data
    } else {
      return []
    }
  }
  
  public class func removeFromFavorites(city:String) {
    SwiftyDefaults.remove(city, forKey: "history")
  }
  
  public class func removeAll() {
    SwiftyDefaults.removeAllObjectsForKey("history")
  }
}
