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
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    
    static var identifierWeatherCollectionViewCell = "weatherCell"    
}
