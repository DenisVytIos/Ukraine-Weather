//
//  MainViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var timer = Timer()
    private var isDataReady: Bool = false
    private var offerModel: OfferModel! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var temperatureMainString: String?
    private var temperatureMinString: String?
    private var temperatureMaxString: String?
    private var windSpeedMainString: String?
    private var airPressureMainString: String?
    private var humidityMainString: String?
    private var pressureMainString: String?
    private var descriptionWeatherMainString: String?
    private var sunriseTimeMainFloat: Float?
    private var sunsetTimeMainFloat: Float?
    private var timeAndDateMainString: String?
    private var cityMainString: String?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather in Ukraine"
        setupSearchBar()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _: DetailViewController = segue.destination as! DetailViewController
        if let _ = segue.identifier {
            if let cell = sender as? CustomTableViewCell,
                let _ = tableView.indexPath(for: cell),
                let seguedToMVC = segue.destination as? DetailViewController {
                if let city = self.offerModel.city {
                    seguedToMVC.cityDetailString = city.name
                }
                seguedToMVC.temperatureDetailString = cell.inTempViewLabel.text
                seguedToMVC.temperatureMaxDetailString = self.temperatureMaxString
                seguedToMVC.temperatureMinDetailString = self.temperatureMinString
                seguedToMVC.airPressureDetailString = cell.airPressureLabel.text
                seguedToMVC.windSpeedDetailString = cell.windSpeedlabel.text
                seguedToMVC.humidityDetailString = self.humidityMainString
                seguedToMVC.descriptionWeatherDetailString = self.descriptionWeatherMainString
                seguedToMVC.sunsetTimeDetailFloat = self.sunsetTimeMainFloat
                seguedToMVC.sunriseTimeDetailFloat = self.sunriseTimeMainFloat
                seguedToMVC.timeAndDateDetailString = self.timeAndDateMainString
                seguedToMVC.offerModelDetail = self.offerModel
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        self.temperatureMainString = cell.inTempViewLabel.text
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowsInSectionInt = 0
        guard isDataReady else { return 0 }
        if let list = self.offerModel.list {
            numberOfRowsInSectionInt = list.count
        }
        return numberOfRowsInSectionInt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifierCustomTableViewCell) as! CustomTableViewCell
        if let city = self.offerModel.city {
            cell.cityLabel.text = city.name
            self.cityMainString = city.name
            if let sunriseFloat = city.sunrise, let sunsetFloat = city.sunset {
                self.sunriseTimeMainFloat = sunriseFloat
                self.sunsetTimeMainFloat = sunsetFloat
            }
        }
        if let list =  self.offerModel.list {
            cell.timeLabel.text = list[indexPath.row].dt_txt
            if let wind = list[indexPath.row].wind, let main = list[indexPath.row].main, let weather = list[indexPath.row].weather {
                if let speed = wind.speed {
                    cell.windSpeedlabel.text = String(format: "%.2f m/s", speed)
                }
                if let temp = main.temp, let pressure = main.pressure, let humidity = main.humidity, let temp_max = main.temp_max, let temp_min = main.temp_min   {
                    cell.inTempViewLabel.text = String(format: "%.0f", temp - 273.15)
                    self.temperatureMainString = cell.inTempViewLabel.text
                    cell.airPressureLabel.text = String(format: "%.0f hpa", pressure)
                    self.pressureMainString = cell.airPressureLabel.text
                    self.humidityMainString = String(format: "%.0f", humidity) + "%"
                    self.temperatureMaxString = String(format: "%.1f", temp_max - 273.15)
                    self.temperatureMinString = String(format: "%.1f", temp_min - 273.15)
                }
                if let description = weather[0].description{
                    self.descriptionWeatherMainString = description.description
                }
            }
        }
        self.timeAndDateMainString =  cell.timeLabel.text
        let weatherOfferModel = WeatherOfferModel.init(tempString: self.temperatureMainString ?? "", tempMinString: self.temperatureMinString ?? "", tempMaxString: self.temperatureMaxString ?? "", pressureString:   self.pressureMainString ?? "", humidityString: self.humidityMainString ?? "", cityString: cell.cityLabel.text ?? "")
        CoreDataManager.shared.save(weathers: [weatherOfferModel]) {
            print ("save")
        }
        print(weatherOfferModel)
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        timer.invalidate()
        if city.count > 1 {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
                NetworkManager.shared.getWeather(city: city, result: { (model, error) in
                    if model != nil {
                        self.isDataReady = true
                        self.offerModel = model
                    }
                })
            })
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
