//
//  CustomTableViewCell.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
  
  override var reuseIdentifier: String? {
    return "CustomTableViewCell"
  }
  
//  @IBOutlet weak var cityLabel: UILabel!
//  @IBOutlet weak var tempMaxLabel: UILabel!
//
//  @IBOutlet weak var tempMinLabel: UILabel!
//  @IBOutlet weak var tempLabel: UILabel!
//  @IBOutlet weak var timeLabel: UILabel!
}
