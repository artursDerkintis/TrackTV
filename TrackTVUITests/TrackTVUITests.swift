//
//  TrackTVUITests.swift
//  TrackTVUITests
//
//  Created by Arturs Derkintis on 24/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import XCTest

class TrackTVUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOpenDetails() {
        
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        app.navigationBars["TrackTV.MovieView"].buttons["Trending Movies"].tap()
        
    }
    
    func testHomepageTrailerOpening(){
        
        
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        app.buttons["Trailer"].tap()
        app.buttons["Done"].tap()
        app.buttons["Homepage"].tap()
        app.buttons["Done"].tap()
        app.navigationBars["TrackTV.MovieView"].buttons["Trending Movies"].tap()
        
        
    }
    
}
