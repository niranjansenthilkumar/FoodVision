//
//  Data.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/8/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import Foundation

struct Food: Decodable {
    let Name: String
    let calories: String
    let caloriesFat: String
    let totalFat: String
    let saturatedFat: String
    let transFat: String
    let cholesterol: String
    let sodium: String
    let totalCarbs: String
    let fiber: String
    let sugars: String
    let vitaminA: String
    let vitaminC: String
    let calcium: String
    let iron: String
    let protein: String
}
