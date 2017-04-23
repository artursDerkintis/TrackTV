//
//  Genre.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RealmSwift

class Genre: Object {
    
    dynamic var genre : String = ""
    
    override class func primaryKey() -> String{
        return "genre"
    }
    
}

extension Genre{
    
    convenience init(string : String?) {
        self.init()
        self.genre = string ?? ""
    }
    
}
