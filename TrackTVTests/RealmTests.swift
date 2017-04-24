//
//  RealmTests.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 24/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import TrackTV

class RealmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRealmStoringAndRetreiving() {
        RealmHelper.realmThread.async {
            if let movieMockJSONString = movieMockJSONString{
                let jsonObject = JSON(parseJSON: movieMockJSONString)
                let tmdb = 419430
                if let movie = Movie.parse(jsonObject: jsonObject){
                    RealmHelper.safeWrite {
                        RealmHelper.realm?.add(movie, update: true)
                        XCTAssertNotNil(Movie.movie(tmdbID: tmdb))
                    }
                }
            }
        }
    }
    
}
