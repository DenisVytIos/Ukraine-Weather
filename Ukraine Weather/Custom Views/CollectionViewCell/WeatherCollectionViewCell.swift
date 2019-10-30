//
//  WeatherCollectionViewCell.swift
//  Ukraine Weather
//
//  Created by Denis on 10/29/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var temperatureMin: UILabel!
  @IBOutlet weak var temperatureMax: UILabel!
  var menu: CollectionViewCellModel? {
    didSet{
      dateLabel.text = menu?.iconWeatherName
    }
  }
}
