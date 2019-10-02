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
  //  "dt_txt": "2019-09-08 18:00:00"
  var dt_txt: String?
  var wind: WindModel?
}
