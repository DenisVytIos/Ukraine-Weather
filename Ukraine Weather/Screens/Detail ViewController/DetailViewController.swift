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
  
  var windSpeedDetail: String?
  var airPressureDetail: String?
  var humidityDetail: String?
  var descriptionWeatherDetail: String?
  var sunriseTimeDetail: Float?
  var sunsetTimeDetail: Float?
  var timeAndDateDetail: String?
  
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
  
  override func viewDidLoad() {
        super.viewDidLoad()
    self.mainTempLabel.textColor = UIColor.black
    self.mainTempLabel.text = temperatureDetail
    self.airPressureLabel.text = airPressureDetail
    self.windSpeedLabel.text = windSpeedDetail
    self.humidityLabel.text = humidityDetail
    self.descriptionWeatherLabel.text = descriptionWeatherDetail
    
    self.sunriseTimeLabel.text = sunriseTimeDetail?.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
    self.sunsetTimeLabel.text = sunsetTimeDetail?.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
    
    self.monthLabel.text = timeAndDateDetail?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.month
    self.dayOfMonthLabel.text = timeAndDateDetail?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.day
    self.dayOfWeekLabel.text = timeAndDateDetail?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.dayOfWeek()!
    
    
    
//    var isoDate = self.offerModel.list![indexPath.row].dt_txt!
//    var i = isoDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")!
//    print(i.month)
//    let calendar = Calendar.current
//    //    let components = calendar.dateComponents([.year, .month, .day, .hour], from: i)
//    
//    _ = NSCalendar.current
//    let components = calendar.dateComponents([.day , .month , .year], from: i)
//
//    let year =  components.year
//    let month = components.month
//    let day = components.day
//    print(i)
//    print(day)
//    print(month)
    //    let dateFormatter = DateFormatter()
    //    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    //    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    //    let date = dateFormatter.date(from:isoDate)
    //    print(date)
    
    
    //  "dt_txt": "2019-09-08 18:00:00"
    
    
    
    setupNavigationBar()
//     self.view.backgroundColor = UIColor.green
//    self.label.text = self.city
//    temp.text = self.parameter
//  
//     temp.backgroundColor = UIColor.black
//    temp.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }
  
  fileprivate func setupNavigationBar() {
    
   
    self.navigationItem.title = self.cityDetail
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    
  }
  
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
}

//extension DetailViewController: UICollectionViewController {
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 2
//  }
//  
//  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//    cell.dateLabel.text = String("Tue 3")
//    return cell
//  }
//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//   let size = CGSize(width: 100, height: 100)
//    return size
//  }
//}
