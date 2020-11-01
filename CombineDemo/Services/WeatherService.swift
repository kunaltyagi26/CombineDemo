//
//  WeatherService.swift
//  CombineDemo
//
//  Created by Kunal Tyagi on 27/10/20.
//

import Foundation
import Combine

struct WeatherService {
    func fetchWeather(city: String)-> AnyPublisher<Weather, Error>? {
        guard let url = URL(string: Constants.Urls.weather.replacingOccurrences(of: "Boston", with: city)) else { return nil }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { ($0.main ?? Weather.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
