//
//  DetailViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var cityDetailString: String?
    var temperatureDetailString: String?
    var temperatureMaxDetailString: String?
    var temperatureMinDetailString: String?
    var windSpeedDetailString: String?
    var airPressureDetailString: String?
    var humidityDetailString: String?
    var descriptionWeatherDetailString: String?
    var sunriseTimeDetailFloat: Float?
    var sunsetTimeDetailFloat: Float?
    var timeAndDateDetailString: String?
    
    var offerModelDetail: OfferModel! {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var airPressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var dayOfMonthLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var sunriseImageView: UIImageView!
    @IBOutlet weak var sunsetImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLabelAndView()
        setupCollectionView()
        DataManager.shared.getWeatherOffer { weather in
            print(weather[0].tempString ?? "not found")
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationItem.title = self.cityDetailString
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupLabelAndView() {
        self.cloudImageView.tintColor = UIColor.white
        self.sunsetImageView.tintColor = UIColor.white
        self.sunriseImageView.tintColor = UIColor.white
        self.mainTempLabel.textColor = UIColor.black
        self.mainTempLabel.text = temperatureDetailString
        self.airPressureLabel.text = airPressureDetailString
        self.windSpeedLabel.text = windSpeedDetailString
        self.humidityLabel.text = humidityDetailString
        self.descriptionWeatherLabel.text = descriptionWeatherDetailString
        self.sunriseTimeLabel.text = sunriseTimeDetailFloat?.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
        self.sunsetTimeLabel.text = sunsetTimeDetailFloat?.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
        self.monthLabel.text = timeAndDateDetailString?.toDate()?.monthString
        self.dayOfMonthLabel.text = timeAndDateDetailString?.toDate()?.dayString
        if let dayOfWeekString = timeAndDateDetailString?.toDate()?.dayOfWeek() {
            self.dayOfWeekLabel.text = dayOfWeekString
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfRowsInSectionInt = 0
        if let list = self.offerModelDetail.list {
            numberOfRowsInSectionInt = list.count
        }
        return numberOfRowsInSectionInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifierWeatherCollectionViewCell, for: indexPath) as? WeatherCollectionViewCell {
            itemCell.weatherImageView.tintColor = UIColor.white
            if let list =  self.offerModelDetail.list {
                itemCell.dateLabel.text = list[indexPath.row].dt_txt?.toDate()?.hourAndDayAndDayOfWeekString
                if  let main = list[indexPath.row].main {
                    if let temp_max = main.temp_max, let temp_min = main.temp_min   {
                        itemCell.temperatureMaxLabel.text = String(format: "%.1f", temp_max - 273.15)
                        itemCell.temperatureMinLabel.text = String(format: "%.1f", temp_min - 273.15)
                    }
                }
            }
            return itemCell
        }
        return UICollectionViewCell()
    }
}

