//
//  ViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
  

  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavigationBar()
  }

  fileprivate func setupNavigationBar() {
    self.navigationItem.title = "Weather Application"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
    //MARK: - UISearchResultsUpdating
  func updateSearchResults(for searchController: UISearchController) {
  print(searchController.searchBar.text ?? "")
  }
  //MARK: - UITableViewDataSource
  
}

