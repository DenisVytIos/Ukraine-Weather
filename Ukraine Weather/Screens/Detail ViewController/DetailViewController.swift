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
    var offerModelDetail: OfferModel!
    
    
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
    
   
    func i() -> String {
        return self.offerModelDetail?.city?.name ?? ""
    }
    
    var itemMenuArray: [CollectionViewCellModel] = {
        var blankMenu = CollectionViewCellModel()
        
        
        blankMenu.iconWeatherName = "cloud"
        blankMenu.tempMax = CoreDataManager.shared.loadCity()
        blankMenu.tempMin = "-5"
        blankMenu.date = "Tue"
    
        
        
        var blankMenu2 = CollectionViewCellModel()
        blankMenu2.iconWeatherName = "cloud"
         blankMenu2.tempMax = "12"
        blankMenu2.tempMin = "-6"
         blankMenu2.date = "Tue"
        
        var blankMenu3 = CollectionViewCellModel()
        blankMenu3.iconWeatherName = "cloud"
        blankMenu3.tempMax = "16"
         blankMenu3.tempMin = "-7"
         blankMenu3.date = "Tue"
        
        var blankMenu4 = CollectionViewCellModel()
        blankMenu4.iconWeatherName = "cloud"
        blankMenu4.tempMax = "15"
        blankMenu4.tempMin = "-8"
         blankMenu4.date = "Tue"
        
        return [blankMenu, blankMenu2, blankMenu3, blankMenu4]
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
        
        //- Формат даты нужно вынести в отдельную константу либо функцию.
        //- в функции toDate() этот формат по дефолту забит, зачем его тогда отсюда передавать?
        //    self.monthLabel.text = timeAndDateDetailString?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.month
        self.monthLabel.text = timeAndDateDetailString?.toDate()?.month
        self.dayOfMonthLabel.text = timeAndDateDetailString?.toDate()?.day
        //- Убрать знак восклицания.
        //- Вообще их нужно избегать везде, использовать if let myVariable...
        if let dayOfWeekString = timeAndDateDetailString?.toDate()?.dayOfWeek() {
            self.dayOfWeekLabel.text = dayOfWeekString
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell {
            itemCell.menu = itemMenuArray[indexPath.row]
            
//            itemCell.backgroundColor = UIColor.green
//            itemCell.dateLabel.text = self.timeAndDateDetailString
//            itemCell.temperatureMaxLabel.text = self.temperatureMaxDetailString
//            itemCell.temperatureMinLabel.text = self.temperatureMinDetailString
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    
}

