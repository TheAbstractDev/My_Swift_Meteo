//
//  SwiftyDefaults.swift
//  My_Swift_Meteo
//
//  Created by Sofiane Beors on 13/06/2016.
//  Copyright © 2016 TheAbstractDev. All rights reserved.
//

import Foundation

public class SwiftyDefaults {
  public class func saveObject(object: AnyObject, forKey key: String) {
    let usersDefaults = NSUserDefaults.standardUserDefaults()
    usersDefaults.setObject(object, forKey: key)
    usersDefaults.synchronize()
  }
  
  public class func objectForKey(key: String) -> AnyObject? {
    let usersDefaults = NSUserDefaults.standardUserDefaults()
  
    if usersDefaults.valueForKey(key) != nil {
      return usersDefaults.objectForKey(key)!
    } else {
      return nil
    }
  }
  
  public class func remove(item: String, forKey key: String) {
    let usersDefaults = NSUserDefaults.standardUserDefaults()
    
    if usersDefaults.objectForKey(key) != nil {
      var data = usersDefaults.objectForKey(key) as! Array<String>
      
      for i in 0 ..< data.count {
        if item == data[i] {
          data.removeAtIndex(i)
          usersDefaults.setObject(data, forKey: key)
          usersDefaults.synchronize()
          break
        }
      }
    }
  }
  
  public class func removeAllObjectsForKey(key: String) {
    let usersDefaults = NSUserDefaults.standardUserDefaults()
    usersDefaults.removeObjectForKey(key)
  }
}