//
//  MainView.swift
//  Ukraine Weather
//
//  Created by Denis on 9/8/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
  
  var tableView = UITableView()
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
   self.firstInitialization()
    self.setupConstraints()
  }
  
  fileprivate func firstInitialization(){
    self.addSubview(tableView)
    //- Для этого хорошая практика использовать твой reuseIdentifier в этом классе, сделать его методом класса
    //- Если хардкодится строка, это делается один раз, у тебя 3 раза, 2 тут и еще один в файле ячейки
    self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
  }
    //- Что касается твоего вопроса про констрейнты
    //- Если интерфейс создается из ксиба или сторибоарда, то все констрейнты выносятся в ксиб
    //- Если интерфейс инифиализируется с кода то тогда в коде естественно все настраивается.
    //- Если из ксиба и нет возможности с него настроить все как нужно, то только в этом случае из кода,
    //- то есть если ты что-то начал настраивать, то хорошо бы все настроить в одном месте, тогда не будет размазанности кода по проекту
    //- Это же касается и коре даты кусок которой у тебя в апп делегате торчит.
    //- Так соблюдается принцип модульности и если что-то нужно переделать, ты изменяешь только в одном месте.
    
  fileprivate func setupConstraints() {
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
}

