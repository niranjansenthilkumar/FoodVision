//
//  APIClient.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/8/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

typealias FoodJSON = [String: Any]

var textScan = ""

struct APIClient {
    static func getFoodAPI(completion: @escaping ([Food?]) -> Void) {
        
        let jsonUrlString = "https://immense-mesa-29392.herokuapp.com/food/" + textScan
        guard let url = URL(string: jsonUrlString) else { return }
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let foods = try JSONDecoder().decode([Food].self, from: data)
                    completion(foods)
                    
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
                }.resume()
        }

    }
}
