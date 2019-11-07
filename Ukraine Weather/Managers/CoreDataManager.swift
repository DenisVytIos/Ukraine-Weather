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
    
    //нам нужен viewContext
    let container = AppDelegate.container
    
    //- Почему не удалены не нужные комментарии
    //- Нужно исправить форматирование - отступы
    //- Почему дефолтное значение температуры не 0? Почему оно не забито в .xcdatamodeld файле а здесь?
    //- Почему обьект называется MainOffer? Это копипаста с другого проекта? Почему в базе данных хранится только одна сущность? Этого достаточно?
    func save() {
        container.viewContext.perform {
            //    cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
            //    cell.tempMinLabel.text = self.offerModel.list![indexPath.row].main!.temp_min!.description
            //     cell.tempLabel.text = self.offerModel.list![indexPath.row].main!.temp!.description
            //     cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
            let mainOfferEntity = MainOfferEntity(context: self.container.viewContext)
            mainOfferEntity.temp = 5
            print("save")
            //- Почему сдесь логируется save и по факту нет сохранения?
        }
        
    }
    func save( temp: Float) {
        container.viewContext.perform {
            //    cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
            //    cell.tempMinLabel.text = self.offerModel.list![indexPath.row].main!.temp_min!.description
            //     cell.tempLabel.text = self.offerModel.list![indexPath.row].main!.temp!.description
            //     cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
            let mainOfferEntity = MainOfferEntity(context: self.container.viewContext)
            
            mainOfferEntity.temp = temp
            print("save")
        }
        
    }
    
    func save( city: String) {
        container.viewContext.perform {
            //    cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
            //    cell.tempMinLabel.text = self.offerModel.list![indexPath.row].main!.temp_min!.description
            //     cell.tempLabel.text = self.offerModel.list![indexPath.row].main!.temp!.description
            //     cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
            let mainOfferEntity = MainOfferEntity(context: self.container.viewContext)
            
            mainOfferEntity.city = city
            print("save")
        }
        
    }
    //- Помему разные функции пошут одинаковый лог это будет сбивать, а не помогать!
    func load() {
        let request: NSFetchRequest<MainOfferEntity> = MainOfferEntity.fetchRequest()
        let mainOfferEntitys = try? container.viewContext.fetch(request)
        print("load")
        print(mainOfferEntitys?.last?.temp ?? "0")
    }
    func loadTemp() ->  String {
        let request: NSFetchRequest<MainOfferEntity> = MainOfferEntity.fetchRequest()
        let mainOfferEntitys = try? container.viewContext.fetch(request)
        print("loadTemp")
        print(mainOfferEntitys?.last?.temp ?? "0")
        
        return "\(String(describing: mainOfferEntitys?.last?.temp))"
    }
    func loadCity() ->  String {
        let request: NSFetchRequest<MainOfferEntity> = MainOfferEntity.fetchRequest()
        let mainOfferEntitys = try? container.viewContext.fetch(request)
        print("loadCity")
        print(mainOfferEntitys?.last?.city ?? "")
        let city = (String(describing: mainOfferEntitys?.last?.city))
        return "\(city)"
    }
}
