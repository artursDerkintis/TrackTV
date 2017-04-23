//
//  Realm+Extensions.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmHelper {
    
    // Returns 'prepared' realm instance
    public static var realm : Realm? {
        var config = Realm.Configuration()
        // If call is comeing from unit tests class - use different realm configuration
        if let _ = NSClassFromString("XCTest") {
            config =  Realm.Configuration(fileURL: nil, inMemoryIdentifier: "test", syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, objectTypes: nil)
        }else{
            config = Realm.Configuration.defaultConfiguration
            // For each update of realm objects schema version should increase or mirgation block should be built
            config.schemaVersion = 0
        }
        do{
            
            return try Realm(configuration: config)
        }catch let error {
            print("something went w w w rr wrrr oooong with realm \(error.localizedDescription)")
            // House MD Reference ^ :) https://www.youtube.com/watch?v=DlT3yd0fU70
            return nil
        }
    }
    
    // Make sure realm is never being tried to write while being in write transition
    public static func safeWrite(block : () -> ()){
        if let realm = RealmHelper.realm{
            if realm.isInWriteTransaction {
                block()
            }
            do{
                try realm.write {
                    block()
                }
            }catch let error{
                print("realm writting error \(error.localizedDescription)")
            }
        }
    }
    
    /// Seperate Thread for Realm
    public static let realmThread : DispatchQueue = DispatchQueue(label : "RealmThread")
    
}
