//
//  RecommendationParser.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class RecommendationParser {
    var recommendationURL: String

    init() {
        self.recommendationURL = "https://fitnetic-api.herokuapp.com/recommendations/"
    }

    // Source: https://fluffy.es/return-value-from-a-closure/
    func getRecommendationData(userID: String, completionHandler: @escaping (Workout?, Error?) -> Void) {
        let destinationURL = self.recommendationURL + userID
        let task = URLSession.shared.dataTask(with: URL(string: destinationURL)!) { (data, response, error) in
        guard let data = data else {
            print("Error: No recommendation data to decode")
            return
        }

        guard let workout = try? JSONDecoder().decode(Workout.self, from: data) else {
            print("Error: Couldn't decode recommendation data into a result")
            return
        }

        completionHandler(workout, nil)
        }

        task.resume()
    }
}
