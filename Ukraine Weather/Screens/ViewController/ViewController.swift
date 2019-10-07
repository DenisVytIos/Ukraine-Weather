//
//  ViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
   var timer = Timer()

  var tempDetail: String?
  var dataIsReady: Bool = false
  
   var offerModel: OfferModel! {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()

      }
    }
  }
 
  var temperatureMain: String?
  var windSpeedMain: String?
  var airPressureMain: String?
  var humidityMain: String?
  var descriptionWeatherMain: String?
  var sunriseTimeMain: Float?
  var sunsetTimeMain: Float?
  var timeAndDateMain: String?
  var temp: Date?
  
  override func viewDidLayoutSubviews() {
  
  }
  override func loadView() {
    super.loadView()
//    self.tempView.round()
//    self.view = MainView()
    
  
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavigationBar()
   tableView.dataSource = self
   tableView.delegate = self

//    self.contentView.tableView.dataSource = self
    
  }

  fileprivate func setupNavigationBar() {
    self.navigationItem.title = "Weather in Ukraine"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
    //MARK: - UISearchResultsUpdating
  func updateSearchResults(for searchController: UISearchController) {
    let city = searchController.searchBar.text!
    timer.invalidate()
    if city.count > 1 {
//      withTimeInterval: 1.5,
      timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
        NetworkManager.shared.getWeather(city: city, result: { (model) in
          if model != nil {
            self.dataIsReady = true
            self.offerModel = model
            
          }
        })
        
      })
    }
  }
  
  //MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if dataIsReady {
      return self.offerModel.list!.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
    cell.backgroundColor = UIColor.gray
    
   cell.cityLabel.text = self.offerModel.city!.name

   cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
    self.timeAndDateMain = self.offerModel.list![indexPath.row].dt_txt
    
   
    
    
    cell.windSpeedlabel.text = String(format: "%.2f m/s", self.offerModel.list![indexPath.row].wind!.speed!)
    
    
     let kelvinTemp = self.offerModel.list![indexPath.row].main!.temp!
      let celsiusTemp = kelvinTemp - 273.15
    let formatedCelsiusTemp = String(format: "%.0f", celsiusTemp)
      cell.inTempViewLabel.text = formatedCelsiusTemp
   
//    self.tempVar = formatedCelsiusTemp
   
//      self.tempVar = String(format: "%.0f", celsiusTemp)
   
    
//    self.tempVar = self.offerModel.list![indexPath.row].main!.temp!.description
//   CoreDataManager.shared.save(temp: self.offerModel.list![indexPath.row].main!.temp!)
//     cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
   
   

    
   cell.airPressureLabel.text = String(format: "%.0f hpa", self.offerModel.list![indexPath.row].main!.pressure!)
    
    self.humidityMain = String(format: "%.0f", self.offerModel.list![indexPath.row].main!.humidity!) + "%"
    self.descriptionWeatherMain = self.offerModel.list![indexPath.row].weather![0].description!.description
    
    
    //
    self.sunriseTimeMain = self.offerModel.city!.sunrise!
    self.sunsetTimeMain = self.offerModel.city!.sunset!
//    self.temp = ViewController.toDate(sunsetTimeMain)
    
    print(self.offerModel.city!.sunset!.getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short))
    return cell
  }
  
   //MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 500
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
    self.temperatureMain = cell.inTempViewLabel.text
//    navigationController?.pushViewController(DetailViewController(parameter: "\(self.offerModel.city!.name ?? "City")"), animated: true)
    
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let _: DetailViewController = segue.destination as! DetailViewController
    if let _ = segue.identifier {
      if let cell = sender as? CustomTableViewCell,
      let _ = tableView.indexPath(for: cell),
        let seguedToMVC = segue.destination as? DetailViewController {
        seguedToMVC.cityDetail = self.offerModel.city!.name ?? "City"
        seguedToMVC.temperatureDetail = cell.inTempViewLabel.text
        seguedToMVC.airPressureDetail = cell.airPressureLabel.text
        seguedToMVC.windSpeedDetail = cell.windSpeedlabel.text
        seguedToMVC.humidityDetail = self.humidityMain
        seguedToMVC.descriptionWeatherDetail = self.descriptionWeatherMain
        seguedToMVC.sunsetTimeDetail = self.sunsetTimeMain
        seguedToMVC.sunriseTimeDetail = self.sunriseTimeMain
        seguedToMVC.timeAndDateDetail = self.timeAndDateMain
        
      }
    
// destinationVC.city = self.offerModel.city!.name ?? "City"
//    destinationVC.tempMain = self.tempVar
// CoreDataManager.shared.load()
  
    }

}
  

}
