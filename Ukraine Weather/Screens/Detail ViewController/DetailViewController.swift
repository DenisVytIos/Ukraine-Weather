//
//  DetailViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
 
  
  var cityDetail: String?
  var temperatureDetail: String?
  var temperatureMaxDetail: String?
  var temperatureMinDetail: String?
  var windSpeedDetail: String?
  var airPressureDetail: String?
  var humidityDetail: String?
  var descriptionWeatherDetail: String?
  var sunriseTimeDetail: Float?
  var sunsetTimeDetail: Float?
  var timeAndDateDetail: String?
  
  
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
  
  var itemMenuArray: [CollectionViewCellModel] = {
    var blankMenu = CollectionViewCellModel()
    blankMenu.iconWeatherName = "Cola"
    return [blankMenu]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupLabelAndView()
    setupCollectionView()
  }
  
  fileprivate func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  fileprivate func setupNavigationBar() {
    self.navigationItem.title = self.cityDetail
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  fileprivate func setupLabelAndView() {
    self.cloudImageView.tintColor = UIColor.white
    self.sunsetImageView.tintColor = UIColor.white
    self.sunriseImageView.tintColor = UIColor.white
    self.mainTempLabel.textColor = UIColor.black
    self.mainTempLabel.text = temperatureDetail
    self.airPressureLabel.text = airPressureDetail
    self.windSpeedLabel.text = windSpeedDetail
    self.humidityLabel.text = humidityDetail
    self.descriptionWeatherLabel.text = descriptionWeatherDetail
    self.sunriseTimeLabel.text = sunriseTimeDetail?.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
    self.sunsetTimeLabel.text = sunsetTimeDetail?.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
    
    //- Формат даты нужно вынести в отдельную константу либо функцию.
    //- в функции toDate() этот формат по дефолту забит, зачем его тогда отсюда передавать?
    self.monthLabel.text = timeAndDateDetail?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.month
    self.dayOfMonthLabel.text = timeAndDateDetail?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.day
    //- Убрать знак восклицания.
    //- Вообще их нужно избегать везде, использовать if let myVariable...
    self.dayOfWeekLabel.text = timeAndDateDetail?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.dayOfWeek()!
    
  }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  return 4
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell {
      itemCell.backgroundColor = UIColor.green
      itemCell.dateLabel.text = self.timeAndDateDetail
      itemCell.temperatureMax.text = self.temperatureMaxDetail
      itemCell.temperatureMin.text = self.temperatureMinDetail
      return itemCell
    }
    return UICollectionViewCell()
  }


}

