//
//  RecommendationViewModel.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RecommendationViewModel: ObservableObject, Identifiable {
    @Published var recommendation: Workout?
    private let recommendationParser: RecommendationParser
    
    init(recommendationParser: RecommendationParser) {
        self.recommendationParser = recommendationParser
//        self.fetchRecommendation(userID: "5dbf3ac810fe5000041aef80")
    }
    
    func fetchRecommendation(userID: String) {
        DispatchQueue.main.async {
            self.recommendationParser.getRecommendationData(userID: userID, completionHandler: {recommendation, error in
                if let recommendation = recommendation {
                    self.recommendation = recommendation
                }
            })
        }
    }
}
