//
//  WorkoutParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

func parseDictionary(_ data: Data?) -> JSONDictionary? {
     do {
       if let d = data {
         let json = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as! [String:AnyObject]
         return json
       }
       return nil
     }
     catch {
       print("error serializing JSON: \(error)")
       return nil
     }
   }

func parseWorkouts(_ dict: JSONDictionary) -> [Workout]? {
    if let workouts = dict["workous"] as? [Workout] {
      return workouts
    }
    return nil
}
