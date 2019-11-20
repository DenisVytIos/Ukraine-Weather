//
//  WeatherOfferEntity.swift
//  Ukraine Weather
//
//  Created by Denis on 11/16/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation
import CoreData

class WeatherOfferEntity: NSManagedObject {
    
    class func findOrCreate(_ weatherOffer: WeatherOfferModel, context: NSManagedObjectContext) throws -> WeatherOfferEntity {
        
        let request: NSFetchRequest<WeatherOfferEntity> = WeatherOfferEntity.fetchRequest()
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                assert(fetchResult.count == 1, "Dublicate has been found in DB!")
                return fetchResult[0]
            }
        } catch  {
            throw error
        }
        let weatherOfferEntity = WeatherOfferEntity(context: context)
        weatherOfferEntity.tempString = weatherOffer.tempString ?? ""
        weatherOfferEntity.tempMaxString = weatherOffer.tempMaxString ?? ""
        weatherOfferEntity.tempMinString = weatherOffer.tempMinString ?? ""
        weatherOfferEntity.pressureString = weatherOffer.pressureString ?? ""
        weatherOfferEntity.humidityString = weatherOffer.humidityString ?? ""
        return weatherOfferEntity
    }
        
    class func allWeather(_ context: NSManagedObjectContext) throws  -> [WeatherOfferEntity] {
        let request: NSFetchRequest<WeatherOfferEntity> = WeatherOfferEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch  {
            throw error
        }
    }
}
