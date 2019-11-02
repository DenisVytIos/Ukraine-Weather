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
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var airPressureLabel: UILabel!
  @IBOutlet weak var windSpeedlabel: UILabel!
  @IBOutlet weak var mapImageView: UIImageView!
  @IBOutlet weak var cloudImageView: UIImageView!
  
  static var identifierCustomTableViewCell = "CustomTableViewCell"

  override func didMoveToSuperview() {
    self.tempView.round()
    self.cloudImageView.tintColor = UIColor.white
    self.mapImageView.tintColor = UIColor.white
  }
  
}
