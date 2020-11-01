//
//  Weather.swift
//  CombineDemo
//
//  Created by Kunal Tyagi on 27/10/20.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Weather?
}

struct Weather: Codable {
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: Weather {
        return Weather(temp: nil, humidity: nil)
    }
}
