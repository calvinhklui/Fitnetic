//
//  ExercisesParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class ExercisesParser {
    var exercisesURL: String

    init() {
        self.exercisesURL = "https://fitnetic-api.herokuapp.com/exercises/"
    }

    // Source: https://fluffy.es/return-value-from-a-closure/
    func getExercisesData(completionHandler: @escaping ([Exercise]?, Error?) -> Void) {
        let destinationURL = self.exercisesURL
        let task = URLSession.shared.dataTask(with: URL(string: destinationURL)!) { (data, response, error) in
            guard let data = data else {
                print("Error: No exercises data to decode")
                return
            }

            guard let exercises = try? JSONDecoder().decode([Exercise].self, from: data) else {
                print("Error: Couldn't decode exercises data into a result")
                return
            }
            
            completionHandler(exercises, nil)
        }

        task.resume()
    }
}
