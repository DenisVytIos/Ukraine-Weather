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
    
    func getWeather(city: String, result: @escaping ((OfferModel?, Error?) -> ())) {
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
                result(decoderOfferModel, nil)
            } else {
                print(error?.localizedDescription as Any)
                result(nil, error)
            }
            }.resume()
    }
    
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
                print(error?.localizedDescription as Any)
            }
            }.resume()
    }
    
    func request(urlString: String, comletion: @escaping (OfferModel?, Error?) -> Void) {
        guard let url = URL(string: urlString)  else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    comletion(nil, error)
                    return
                }
                guard let data = data else { return }
                do {
                    let decoderOfferModel = try JSONDecoder().decode(OfferModel.self, from: data)
                    comletion(decoderOfferModel, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    comletion(nil, jsonError)
                }
            }
            }.resume()
    }
}

