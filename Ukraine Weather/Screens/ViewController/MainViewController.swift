//
//  MainViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    //- Никогда не называй так вью контроллеры
    //- например MainViewController or HomeViewController or Details... List...
    
    
    @IBOutlet weak var tableView: UITableView!
    private var timer = Timer()
    //  private var tempDetail: String?
    private var isDataReady: Bool = false
    private var offerModel: OfferModel! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //- Хорошая практика в конце имени переменной писать ее тип, например:
    //- timeAndDateMainString, ...
    //- Bool переменные просто начинаются с is...
    //- tempDate, кстати почему у переменной температура тип Date???
    
    private var temperatureMainString: String?
    private var temperatureMinString: String?
    private var temperatureMaxString: String?
    private var windSpeedMainString: String?
    private var airPressureMainString: String?
    private var humidityMainString: String?
    private var descriptionWeatherMainString: String?
    private var sunriseTimeMainFloat: Float?
    private var sunsetTimeMainFloat: Float?
    private var timeAndDateMainString: String?
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather in Ukraine"
        setupSearchBar()
        setupTableView()
        CoreDataManager.shared.save(city: "Kiev")
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
    
    //- Это настраивается во вью дид лоаде
    //- Если в фанкции 1 строка и она вызывается один раз, то чаще всего нет смысла чтоб выносить отдельно
    
    
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
    
    //- Дефолтную высоту и эстимейтед высоту также нужно вынести в ксиб, это улучшит производительность и уменьшит количество кода
//      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//      }
//      
//      func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        self.temperatureMainString = cell.inTempViewLabel.text
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //- else тут не нужно писать, нужно стараться минимализировать количество кода
        var numberOfRowsInSectionInt = 0
        guard isDataReady else { return 0 }
        if let list = self.offerModel.list {
            numberOfRowsInSectionInt = list.count
        }
        return numberOfRowsInSectionInt
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //- Опять закардкожен идентияикатор, этого тут быть не должно
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifierCustomTableViewCell) as! CustomTableViewCell
        if let city = self.offerModel.city {
            cell.cityLabel.text = city.name
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
                    cell.airPressureLabel.text = String(format: "%.0f hpa", pressure)
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
        return cell
    }
}

//    cell.cityLabel.text = self.offerModel.city!.name
//     cell.windSpeedlabel.text = String(format: "%.2f m/s", self.offerModel.list[indexPath.row].wind!.speed!)
//      if let main = list[indexPath.row].main {
//
//      }
//      if let weather = list[indexPath.row].weather {
//        if let description = weather[0].description {
//          self.descriptionWeatherMainString = description.description
//        }
//
//      }
//    cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
//
//    cell.windSpeedlabel.text = String(format: "%.2f m/s", self.offerModel.list![indexPath.row].wind!.speed!)
//    cell.inTempViewLabel.text = String(format: "%.0f", self.offerModel.list![indexPath.row].main!.temp! - 273.15)
//    cell.airPressureLabel.text = String(format: "%.0f hpa", self.offerModel.list![indexPath.row].main!.pressure!)
//    self.humidityMainString = String(format: "%.0f", self.offerModel.list![indexPath.row].main!.humidity!) + "%"
//    self.descriptionWeatherMainString = self.offerModel.list![indexPath.row].weather![0].description!.description
//    self.sunriseTimeMainFloat = self.offerModel.city!.sunrise!
//    self.sunsetTimeMainFloat = self.offerModel.city!.sunset!

//    self.temperatureMaxString = String(format: "%.1f", self.offerModel.list![indexPath.row].main!.temp_max! - 273.15)
//    self.temperatureMinString = String(format: "%.1f", self.offerModel.list![indexPath.row].main!.temp_min! - 273.15)
//    print(String(format: "%.0f", self.offerModel.list![indexPath.row].main!.temp_max! - 273.15))
//    print(String(format: "%.0f", self.offerModel.list![indexPath.row].main!.temp_min! - 273.15))


//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        timer.invalidate()
        if city.count > 1 {
            //      withTimeInterval: 1.5,
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
