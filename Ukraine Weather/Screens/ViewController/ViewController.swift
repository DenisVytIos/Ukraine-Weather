//
//  ViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var timer = Timer()
  private var tempDetail: String?
  private var dataIsReady: Bool = false
  private var offerModel: OfferModel! {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  private var temperatureMain: String?
  private var windSpeedMain: String?
  private var airPressureMain: String?
  private var humidityMain: String?
  private var descriptionWeatherMain: String?
  private var sunriseTimeMain: Float?
  private var sunsetTimeMain: Float?
  private var timeAndDateMain: String?
  private var temp: Date?
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    setupNavigationBar()
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = UIColor.darkGray
  }
  
  private func setupSearchBar() {
    navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Enter the city"
    searchController.definesPresentationContext = true
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  fileprivate func setupNavigationBar() {
    self.navigationItem.title = "Weather in Ukraine"
    
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
    }
  }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource  {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 500
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
    self.temperatureMain = cell.inTempViewLabel.text
  }
  
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
    self.timeAndDateMain =  cell.timeLabel.text
    cell.windSpeedlabel.text = String(format: "%.2f m/s", self.offerModel.list![indexPath.row].wind!.speed!)
    cell.inTempViewLabel.text = String(format: "%.0f", self.offerModel.list![indexPath.row].main!.temp! - 273.15)
    cell.airPressureLabel.text = String(format: "%.0f hpa", self.offerModel.list![indexPath.row].main!.pressure!)
    self.humidityMain = String(format: "%.0f", self.offerModel.list![indexPath.row].main!.humidity!) + "%"
    self.descriptionWeatherMain = self.offerModel.list![indexPath.row].weather![0].description!.description
    self.sunriseTimeMain = self.offerModel.city!.sunrise!
    self.sunsetTimeMain = self.offerModel.city!.sunset!
    return cell
  }
}

//MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let city = searchController.searchBar.text!
    timer.invalidate()
    if city.count > 1 {
      //      withTimeInterval: 1.5,
      timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
        NetworkManager.shared.getWeather(city: city, result: { (model) in
          if model != nil {
            self.dataIsReady = true
            self.offerModel = model
          }
        })
      })
    }
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
  }
}
