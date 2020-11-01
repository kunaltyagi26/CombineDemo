//
//  Constants.swift
//  CombineDemo
//
//  Created by Kunal Tyagi on 27/10/20.
//

import Foundation

struct Constants {
    struct Urls {
        static let weather = "https://api.openweathermap.org/data/2.5/weather?q=Boston&appid=\(Constants.apiKey)&units=imperial"
    }
    
    static let apiKey = "85c96101d79fbf8ddbb2ed2a803422f8"
}
