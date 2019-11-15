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
    
    
    // MARK: - Core Data stack
    
    //- Всю работы с базой данных необходимо вынести в отдельный класс, здесь не должно быть этого кода
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Ukraine_Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //- Почему не удалены не нужные комментарии
    //- Нужно исправить форматирование - отступы
    //- Почему дефолтное значение температуры не 0? Почему оно не забито в .xcdatamodeld файле а здесь?
    //- Почему обьект называется MainOffer? Это копипаста с другого проекта? Почему в базе данных хранится только одна сущность? Этого достаточно?
    func save() {
        //        persistentContainer.viewContext.perform {
        //            //    cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
        //            //    cell.tempMinLabel.text = self.offerModel.list![indexPath.row].main!.temp_min!.description
        //            //     cell.tempLabel.text = self.offerModel.list![indexPath.row].main!.temp!.description
        //            //     cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
        //            let user = UserEntity(context: self.persistentContainer.viewContext)
        //            user.id = UUID().uuidString
        //            user.name = "Slava"
        //            print("save")
        //            print(user.id)
        //
        //            print("save")
        //            //- Почему сдесь логируется save и по факту нет сохранения?
        //        }
        
        persistentContainer.viewContext.perform {
            //            let post = PostEntity(context: self.persistentContainer.viewContext)
            
            //            post.id = UUID().uuidString
            //            post.title = "title"
            
            //            let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            //            let users = try? self.persistentContainer.viewContext.fetch(request)
            
            //            post.user = users?.last
        }
        
    }
    
   
    //- Помему разные функции пошут одинаковый лог это будет сбивать, а не помогать!
    func load() {
        //        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        //        let users = try? persistentContainer.viewContext.fetch(request)
        print("load")
        //        print(users?.last?.posts?.count)
    }
    
    
    func getAllUsers(_ complitionHandler:@escaping ([User]) -> Void)  {
       let viewContext = persistentContainer.viewContext
        viewContext.perform {
            
            
               let userEntities = try? UserEntity.all(viewContext)
            let dbUsers = userEntities?.map({ User(entity: $0)})
            
         complitionHandler(dbUsers ?? [])
        }
        
    }
    
    func save(users: [User], _ complitionHandler:@escaping () ->  (Void)) {
        let  viewContext = persistentContainer.viewContext
        viewContext.perform {
            for user in users {
                _ = try? UserEntity.findOrCreate(user, context: viewContext)
            }
            try? viewContext.save()
            
            complitionHandler()
        }
    }
}





