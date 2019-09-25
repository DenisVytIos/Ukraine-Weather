//
//  NetworkManager.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class NetworkManager {
  private init () {}
  
  static let shared = NetworkManager()
  
  func getWeather(city: String, result: @escaping ((OfferModel?) -> ())) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.openweathermap.org"
    urlComponents.path = "/data/2.5/forecast"
    
    urlComponents.queryItems = [URLQueryItem(name: "q", value: city), URLQueryItem(name: "appid",
                                                                                   value: "7714d6122dd839b45d181c53b0f4ecfc")]
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "GET"
    
    let task = URLSession(configuration: .default)
    task.dataTask(with: request) { (data, response, error) in
      if error == nil {
        let decoder = JSONDecoder()
        var decoderOfferModel: OfferModel?
        
        if data != nil {
          decoderOfferModel = try? decoder.decode(OfferModel.self, from: data!)
          
        }
        result(decoderOfferModel)
      } else {
        print(error as Any)
      }
    }.resume()
  }
}
