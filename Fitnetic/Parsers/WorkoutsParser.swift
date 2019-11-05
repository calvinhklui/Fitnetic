//
//  WorkoutsParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class WorkoutsParser {
    var workoutsURL: String

    init() {
        self.workoutsURL = "https://fitnetic-api.herokuapp.com/workouts?user="
    }

    // Source: https://fluffy.es/return-value-from-a-closure/
    func getWorkoutsData(userID: String, completionHandler: @escaping ([Workout]?, Error?) -> Void) {
        let destinationURL = self.workoutsURL + userID
        let task = URLSession.shared.dataTask(with: URL(string: destinationURL)!) { (data, response, error) in
        guard let data = data else {
            print("Error: No workouts data to decode")
            return
        }

        guard let workouts = try? JSONDecoder().decode([Workout].self, from: data) else {
            print("Error: Couldn't decode workouts data into a result")
            return
        }
            
        completionHandler(workouts, nil)
        }

        task.resume()
    }
    
//    // Source: https://www.raywenderlich.com/4161005-mvvm-with-combine-tutorial-for-ios
//    func returnWorkoutsData(
//      forCity city: String
//    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
//      return forecast(with: makeWeeklyForecastComponents(withCity: city))
//    }
}
