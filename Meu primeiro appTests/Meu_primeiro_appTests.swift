//
//  Meu_primeiro_appTests.swift
//  Meu primeiro appTests
//
//  Created by Jonathan on 30/01/20.
//  Copyright © 2020 teste. All rights reserved.
//

import XCTest
@testable import Meu_primeiro_app

class FoodTrackerTests: XCTestCase {
    
 //MARK: Meal Class Tests
// Confirm that the Meal initializer returns a Meal object when passed valid parameters.
func testMealInitializationSucceeds() {
    // Zero rating
    let zeroRatingMeal = Bar.init(name: "Zero", photo: nil, rating: 0, Telefone: "zero", Longitude: 0, Latitude: 0 )
    XCTAssertNotNil(zeroRatingMeal)
    
    // Highest positive rating
    let positiveRatingMeal = Bar.init(name: "Zero", photo: nil, rating: 5, Telefone: "zero", Longitude: 0, Latitude: 0 )
    XCTAssertNotNil(positiveRatingMeal)
}
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitializationFails() {
        // Negative rating
        let negativeRatingMeal = Bar.init(name: "Negative", photo: nil, rating: -1, Telefone: "Zero", Longitude: -1, Latitude: -1)
        XCTAssertNil(negativeRatingMeal)
        
        
        // Rating exceeds maximum
        let largeRatingMeal = Bar .init(name: "Large", photo: nil,  rating: 6, Telefone: "Zero", Longitude: -1, Latitude: -1)
        XCTAssertNil(largeRatingMeal)
        
        // Empty String
        let emptyStringMeal = Bar.init(name: "", photo: nil, rating: 0, Telefone: "Zero", Longitude: -1, Latitude: -1)
        XCTAssertNil(emptyStringMeal)
    }
    func testBarTelefone(){
        let StringTelefone = Bar.init(name: "", photo: nil, rating: 0, Telefone: "000000000000", Longitude: 1, Latitude: 1)
        XCTAssertNil(StringTelefone)
    }
}


