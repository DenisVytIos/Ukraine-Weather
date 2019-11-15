//
//  User.swift
//  Ukraine Weather
//
//  Created by Denis on 11/12/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class User: Codable {
    var id = 2
    var name = "Ivan"
    var userName = "User name"
    var email = "123@gmail.com"
    
    init(entity: UserEntity) {
        self.id = Int(entity.id)
        self.name = entity.name ?? ""
        self.userName = entity.userName ?? ""
        self.email = entity.email ??  ""
    }
}
