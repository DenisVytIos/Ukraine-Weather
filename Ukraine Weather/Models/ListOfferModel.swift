//
//  ListOfferModel.swift
//  Ukraine Weather
//
//  Created by Denis on 9/8/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class ListOfferModel: Codable {
    var dt: Float?
    var main: MainOfferModel?
    var dt_txt: String?
    var wind: WindModel?
    var weather: [WeatherModel]?
}

