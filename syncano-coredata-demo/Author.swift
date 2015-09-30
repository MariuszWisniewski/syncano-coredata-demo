//
//  Author.swift
//  syncano-coredata-demo
//
//  Created by Mariusz Wisniewski on 9/26/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

import UIKit

class Author: SCDataObject {
    var firstName = ""
    var lastName = ""
    
    //use to change iOS variable name to something else than used on Syncano
    //in this case we're changing last_name and first_name defined in an Author class
    //on Syncano, to lastName and firstName which is more iOS style
    override class func extendedPropertiesMapping() -> [NSObject: AnyObject] {
        return [
            "firstName":"first_name",
            "lastName":"last_name"
        ]
    }
}
