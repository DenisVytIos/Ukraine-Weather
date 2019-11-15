//
//  DataManager.swift
//  Ukraine Weather
//
//  Created by Denis on 11/12/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class DataManager {
    let coreDataManager = CoreDataManager.shared
    let networkManager = NetworkManager.shared
    
    func getAllUsers(_ complitionHandler: @escaping([User]) -> Void) {
        coreDataManager.getAllUsers { (users) in
            if  users.count > 0 {
               print("from DB")
                complitionHandler(users)
            } else {
                self.networkManager.getWeather(city: "Kiev", result: { (model, error) in
                    if model != nil {
                        self.coreDataManager.save(users: users) {
                            complitionHandler(users)
                        }
                        
                        
                    }
            })
        }
        
    }
}
}
