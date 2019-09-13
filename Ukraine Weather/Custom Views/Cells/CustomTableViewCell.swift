//
//  CustomTableViewCell.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  @IBOutlet weak var tempView: UIView!
  
  @IBOutlet weak var inTempViewLabel: UILabel!
  
  override var reuseIdentifier: String? {
    return "CustomTableViewCell"
  }
  
  override func didMoveToSuperview() {
    self.tempView.round()
    self.inTempViewLabel.text = "6"
    
  }


}
