//
//  AuthorEntity.swift
//  syncano-coredata-demo
//
//  Created by Mariusz Wisniewski on 9/26/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

import Foundation
import CoreData

class AuthorEntity: NSManagedObject {

    @NSManaged var authorId: NSNumber
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var books: NSSet
    
    class func createOrUpdateWithAuthor(author: Author, inContext context: NSManagedObjectContext) -> AuthorEntity? {
        var authorEntity = self.authorWithId(author.objectId, inContext: context)
        if (authorEntity == nil) {
            authorEntity = AuthorEntity.MR_createEntityInContext(context)
        }
        authorEntity?.firstName = author.firstName
        authorEntity?.lastName = author.lastName
        authorEntity?.authorId = author.objectId
        return authorEntity
    }
    
    class func authorWithId(authorId: NSNumber, inContext context: NSManagedObjectContext) -> AuthorEntity? {
        let authorEntity = AuthorEntity.MR_findFirstByAttribute("authorId", withValue:authorId, inContext: context)
        return authorEntity
    }

}
