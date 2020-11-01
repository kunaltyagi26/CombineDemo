//
//  WeatherViewController.swift
//  CombineDemo
//
//  Created by Kunal Tyagi on 27/10/20.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    private var weatherService = WeatherService()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*cancellable = weatherService.fetchWeather(city: "Houston")?
            .catch { _ in Just(Weather.placeholder) }
            .map { weather in
                if let temp = weather.temp {
                    return "\(temp) ℉"
                } else {
                    return "Error fetching weather."
                }
            }.assign(to: \.text, on: temperatureLabel)*/
        
        setupPublisher()
    }
    
    func setupPublisher() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: cityTextField)
        
        cancellable = publisher.compactMap {
            ($0.object as? UITextField)?.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        }.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .flatMap { city in
            return ((self.weatherService.fetchWeather(city: city)?
                        .catch { _ in Just(Weather.placeholder) }
                        .map { $0 }))!
        }.sink { weather in
            if let temp = weather.temp {
                self.temperatureLabel.text = "\(temp) ℉"
            } else {
                self.temperatureLabel.text = ""
            }
            
        }
    }
}
