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
    
    override func didMoveToSuperview() {
        
    }
    
    var menu: CollectionViewCellModel? {
        didSet{
            dateLabel.text = menu?.date
            temperatureMaxLabel.text = menu?.tempMax
            temperatureMinLabel.text = menu?.tempMin
            if let image = menu?.iconWeatherName {
                weatherImageView.image = UIImage(named: image)
            }
        }
    }
}
