//
//  CollectionViewCell.swift
//  Ukraine Weather
//
//  Created by Denis on 9/19/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var cloudLabel: UIImageView!
  @IBOutlet weak var dayTempLabel: UILabel!
  @IBOutlet weak var nightLabel: UILabel!
}
