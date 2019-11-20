//
//  DataManager.swift
//  Ukraine Weather
//
//  Created by Denis on 11/12/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class DataManager {
    
    private init () {}
    static let shared = DataManager()
    
    let coreDataManager = CoreDataManager.shared
    let networkManager = NetworkManager.shared
    var cityString = WeatherOfferModel.cityString
    func getWeatherOffer (_ complitionHandler: @escaping([WeatherOfferModel]) -> Void) {
        coreDataManager.getWeatherOffer { (weather) in
            if  weather.count > 0 {
                print("from DB")
                complitionHandler(weather)
            } else {
                self.networkManager.getWeather(city: self.cityString ?? "", result: { (model, error) in
                    if model != nil {
                        self.coreDataManager.save(weathers: weather) {
                            complitionHandler(weather)
                        }
                    }
                })
            }
        }
    }
}
