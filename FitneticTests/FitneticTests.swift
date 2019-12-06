//
//  FitneticTests.swift
//  FitneticTests
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import XCTest
@testable import Fitnetic

var globalUserID: String = "5dbf3ac810fe5000041aef80"

class FitneticTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserObserver() {
        let test_user_observer = UserObserver()
      
        XCTAssertNotNil(test_user_observer)
        XCTAssertNotNil(test_user_observer.user)
        XCTAssert((test_user_observer.user.lastName as Any) is String)
        XCTAssert((test_user_observer.user.id as Any) is String)
        XCTAssert((test_user_observer.user.dateOfBirth as Any) is String)
        XCTAssert((test_user_observer.user.goal as Any) is String)
      
        test_user_observer.setUser(dummyUser)
        XCTAssertEqual(test_user_observer.user.id, "edcba123")
      
      test_user_observer.postData(completion: { (success) -> Void in
        print(success)
      })
      XCTAssertEqual(test_user_observer.user.username, "calvinhklui")
      
      test_user_observer.updateData(completion: { (success) -> Void in
        print(success)
      })
      XCTAssertEqual(test_user_observer.user.username, "calvinhklui")
    }
  
    func testExercisesObserver() {
        let test_exercise_observer = ExercisesObserver()
        XCTAssertNotNil(test_exercise_observer)
        XCTAssertNotNil(test_exercise_observer.exercises)
        for exercise in test_exercise_observer.exercises {
          XCTAssert((exercise.id as Any) is String)
          XCTAssert((exercise.name as Any) is String)
          XCTAssert((exercise.muscles as Any) is [Muscle])
        }
        
        test_exercise_observer.fetchData()
    }
    
    func testWorkoutsObserver() {
      let test_workouts_observer = WorkoutsObserver()
      XCTAssertNotNil(test_workouts_observer)
      XCTAssertNotNil(test_workouts_observer.workouts)
      for workout in test_workouts_observer.workouts {
        XCTAssert((workout.id as Any) is String)
        XCTAssert((workout.user as Any) is User)
        XCTAssert((workout.date as Any) is String)
        XCTAssert((workout.sets as Any) is [WorkoutSet])
      }
      
    }
  
    func testWorkoutObserver() {
      let test_workout_observer = WorkoutObserver()
      XCTAssertNotNil(test_workout_observer)
      XCTAssertNotNil(test_workout_observer.workout)
      XCTAssert((test_workout_observer.workout as Any) is Workout)
      
      let dummyRecommendation = Workout(
        id: "abcde123",
        user: dummyUser,
        date: "11/05/2019",
        sets: []
      )
      test_workout_observer.setWorkout(dummyRecommendation)
      XCTAssertEqual(test_workout_observer.workout.id, "abcde123")
      
      test_workout_observer.postData(completion: { (success) -> Void in
        if (success == true) {
          XCTAssertNotNil(test_workout_observer.workout)
          XCTAssertEqual(test_workout_observer.loading, false)
          XCTAssertEqual(test_workout_observer.workout.user.id, "5dbf3ac810fe5000041aef80")
        } else {
          XCTAssertEqual(test_workout_observer.loading, true)
        }
      })
      XCTAssertEqual(test_workout_observer.workout.id, "abcde123")
    }
  
    func testAnalyticsObserver() {
      let test_analytics_observer = AnalyticsObserver()
      XCTAssertNotNil(test_analytics_observer)
      XCTAssertNotNil(test_analytics_observer.analytics)
      XCTAssert((test_analytics_observer.analytics as Any) is Analytics)
      test_analytics_observer.fetchData()
      XCTAssertEqual(test_analytics_observer.loading, true)
      test_analytics_observer.fetchSVG()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
        XCTAssertNotNil(test_analytics_observer.analytics)
        XCTAssertNotNil(test_analytics_observer.heatmap)
        XCTAssertEqual(test_analytics_observer.loading, false)
      }
  }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
