//
//  UserEntity .swift
//  Ukraine Weather
//
//  Created by Denis on 11/12/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation
import CoreData

class UserEntity : NSManagedObject {
    
    class func findOrCreate(_ user: User, context: NSManagedObjectContext) throws -> UserEntity {
        
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", user.id)
        
        do {
            let fetchResult = try context.fetch(request)
            
            if fetchResult.count > 0 {
                assert(fetchResult.count == 1, "Dublicate has been found in DB!")
                return fetchResult[0]
            }
            
        } catch  {
            throw error
        }
        
        let userEntity = UserEntity(context: context)
        userEntity.id = Int64(user.id)
        userEntity.name = user.name
        userEntity.userName = user.userName
        userEntity.email = user.email
        
        return userEntity
    }
    
    class func all(_ context: NSManagedObjectContext) throws  -> [UserEntity] {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch  {
            throw error
        }
    }
}