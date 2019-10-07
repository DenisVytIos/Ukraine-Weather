//
//  WeatherModel.swift
//  Ukraine Weather
//
//  Created by Denis on 10/3/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class WeatherModel: Codable {
  //  "weather": [
    //  {
        //  "id": 804,
        //  "main": "Clouds",
        //  "description": "overcast clouds",
        //  "icon": "04d"
        //  }
  //  ],
  var id: Float?
  var main: String?
  var description: String?
  var icon: String?
  
  
}
