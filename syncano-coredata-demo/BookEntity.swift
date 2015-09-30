//
//  BookEntity.swift
//  syncano-coredata-demo
//
//  Created by Mariusz Wisniewski on 9/26/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

import Foundation
import CoreData

class BookEntity: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var numberOfPages: NSNumber
    @NSManaged var bookId: NSNumber
    @NSManaged var author: AuthorEntity?
    
    class func createOrUpdateWithBook(book: Book, inContext context:NSManagedObjectContext) {
        var bookEntity = BookEntity.bookWithId(book.objectId, inContext: context)
        if (bookEntity == nil) {
            bookEntity = BookEntity.MR_createEntityInContext(context)
        }
        bookEntity?.title = book.title
        bookEntity?.numberOfPages = book.numberOfPages
        bookEntity?.bookId = book.objectId
        if let authorId = book.author?.objectId {
            var authorEntity = AuthorEntity.authorWithId(authorId, inContext: context)
            if (authorEntity == nil) {
                authorEntity = AuthorEntity.createOrUpdateWithAuthor(book.author!, inContext: context)
            }
            bookEntity?.author = authorEntity
        }
    }
    
    class func bookWithId(bookId: NSNumber, inContext context: NSManagedObjectContext) -> BookEntity? {
        let bookEntity = BookEntity.MR_findFirstByAttribute("bookId", withValue:bookId, inContext: context)
        return bookEntity
    }


}
