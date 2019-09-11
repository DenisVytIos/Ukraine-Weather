//
//  ViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
   var timer = Timer()
  
  fileprivate var contentView: MainView {
    return self.view as! MainView
  }
  var tempDetail: String?
  var dataIsReady: Bool = false
  
   var offerModel: OfferModel! {
    didSet {
      DispatchQueue.main.async {
        self.contentView.tableView.reloadData()

      }
    }
  }
  override func loadView() {
    super.loadView()
//    self.view = MainView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavigationBar()
   (self.view as! MainView).tableView.dataSource = self
    (self.view as! MainView).tableView.delegate = self
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
    cell.cityLabel.text = self.offerModel.city!.name
    cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
    cell.tempMinLabel.text = self.offerModel.list![indexPath.row].main!.temp_min!.description
     cell.tempLabel.text = self.offerModel.list![indexPath.row].main!.temp!.description
     cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
    return cell
  }
   //MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 350
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.pushViewController(DetailViewController(parameter: "\(self.offerModel.city!.name ?? "City")"), animated: true)
    }
  override func prepareForInterfaceBuilder() {
    
  }
  
}

