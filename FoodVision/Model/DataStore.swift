//
//  DataStore.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/8/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {

    static let sharedInstance = DataStore()
    fileprivate init() {}

    var foods: [Food] = []
    var name: [String] = []
    var calorieInfo: [String] = []
    var fatInfo: [String] = []
    var carbInfo: [String] = []
    var vitaminInfo: [String] = []
    
    var pieTableInfo: [String] = []
    
    var percentF: Double = 0
    var percentP: Double = 0
    var percentC: Double = 0
    var percentT: Double = 0

    
    let cells = ["label", "calories", "breakdown", "threecell", "singlecell", "singlecell", "carbcell","vitamin", "singlecell"]
    
    let cellLabels = ["Name", "Calories", "Breakdown", "ThreeCell", "Cholesterol (mg)", "Sodium (mg)", "ThreeCell","Vitamins", "Protein (g)"]

    func getFood(completion: @escaping () -> Void) { 
        
        APIClient.getFoodAPI { (food) in
            let copy = food
            for dict in copy {
                self.foods.append(dict!)
            }
            completion()
        }
    }
    
    func getFoodName(completion: @escaping () -> Void) {
        getFood {
            for foo in self.foods {
                self.name.append(foo.Name)
                //calories
                self.name.append("calories")
                //breakdown
                self.name.append("breakdown")
                //threecell
                self.name.append("threecell")
                //cholesterol
                self.name.append(foo.cholesterol)
                //sodium
                self.name.append(foo.sodium)
                //threecell
                self.name.append("threecell")
                //vitamins
                self.name.append("vitamins")
                //protein
                self.name.append(foo.protein)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    func getCalorieInfo(completion: @escaping () -> Void) {
        getFood {
            for foo in self.foods {
                self.calorieInfo.append(foo.calories)
                self.calorieInfo.append(foo.caloriesFat)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    func getFatInfo(completion: @escaping () -> Void) {
        getFood {
            for foo in self.foods {
                self.fatInfo.append(foo.totalFat)
                self.fatInfo.append(foo.saturatedFat)
                self.fatInfo.append(foo.transFat)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    func getCarbInfo(completion: @escaping () -> Void) {
        getFood {
            for foo in self.foods {
                self.carbInfo.append(foo.totalCarbs)
                self.carbInfo.append(foo.fiber)
                self.carbInfo.append(foo.sugars)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    func getVitaminInfo(completion: @escaping () -> Void) {
        getFood {
            for foo in self.foods {
                self.vitaminInfo.append(foo.vitaminA)
                self.vitaminInfo.append(foo.vitaminC)
                self.vitaminInfo.append(foo.calcium)
                self.vitaminInfo.append(foo.iron)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    func getPieInfo(completion: @escaping () -> Void) {
        getFood {
            for foo in self.foods {
                guard let intFat = Double(foo.totalFat) else { return }
                guard let intCarbs = Double(foo.totalCarbs) else { return }
                guard let intProtein = Double(foo.protein) else { return }
                
                let calFat = intFat * 9.0
                let calProtein = intProtein * 4.0
                let calCarbs = intCarbs * 4.0
                
                let total = calFat + calCarbs + calProtein
                
                let percentFat = calFat/total * 100
                let percentProtein = calProtein/total * 100
                let percentCarbs = calCarbs/total * 100
                
                self.percentF = percentFat
                self.percentP = percentProtein
                self.percentC = percentCarbs
                
                self.percentT = percentFat + percentCarbs + percentProtein
                
                
                //round values then convert to string
                let stringValueCarbs = String(Int(percentCarbs.rounded()))
                let stringValueFat = String(Int(percentFat.rounded()))
                let stringValueProtein = String(Int(percentProtein.rounded()))
                
                self.pieTableInfo.append(stringValueCarbs)
                self.pieTableInfo.append(stringValueFat)
                self.pieTableInfo.append(stringValueProtein)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
}
