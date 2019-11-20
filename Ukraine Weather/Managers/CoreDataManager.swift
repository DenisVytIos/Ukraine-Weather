//
//  CoreDataManager.swift
//  Ukraine Weather
//
//  Created by Denis on 9/25/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private init () {}
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Ukraine_Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getWeatherOffer(_ complitionHandler:@escaping ([WeatherOfferModel]) -> Void)  {
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            let weatherOfferEntities = try? WeatherOfferEntity.allWeather(viewContext)
            let dbWeatherOffer = weatherOfferEntities?.map({ WeatherOfferModel(entity: $0)})
            complitionHandler(dbWeatherOffer ?? [])
        }
    }
    
    func save(weathers: [WeatherOfferModel], _ complitionHandler:@escaping () ->  (Void)) {
        let  viewContext = persistentContainer.viewContext
        viewContext.perform {
            for weather in weathers {
                _ = try? WeatherOfferEntity.findOrCreate(weather, context: viewContext)
            }
            try? viewContext.save()
            
            complitionHandler()
        }
    }
}





