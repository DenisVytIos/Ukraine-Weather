//
//  OfferModel.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class OfferModel: Codable {
  //  "cod": "200",
  //  "message": 0.0086,
  //  "cnt": 40,
  //  "list": [
  
  var cod: String?
  var message: Float?
  var cnt: Float?
  var list: [ListOfferModel]?
  
  var city: CityModel?
}
