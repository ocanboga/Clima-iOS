//
//  WeatherManager.swift
//  Clima
//
//  Created by osman canboga on 2.03.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreVideo

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=764bf2ba40065edf8fdc6cbf58257cd7&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString )
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error!")
                    return
                }
                
                if let safeData = data{
                    parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name  = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.temperatureString)
        }catch{
            print("error!")
            
        }
    }
    
}
