//
//  Book.swift
//  syncano-coredata-demo
//
//  Created by Mariusz Wisniewski on 9/26/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

import UIKit

class Book: SCDataObject {
    var title = ""
    var numberOfPages = 0
    var author : Author? = nil
    
    //use to change iOS variable name to something else than used on Syncano
    //in this case we're changing number_of_pages defined in a Book class
    //on Syncano, to numberOfPages which is more iOS style
    override class func extendedPropertiesMapping() -> [NSObject: AnyObject] {
        return [
            "numberOfPages":"number_of_pages"
        ]
    }
}
