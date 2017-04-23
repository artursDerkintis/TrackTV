//
//  DataTests.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import TrackTV

class DataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMovieObjectCreation() {
        if let movieMockJSONString = self.movieMockJSONString{
            let jsonObject = JSON(parseJSON: movieMockJSONString)
            let movie = Movie.parse(jsonObject: jsonObject)
            XCTAssertNotNil(movie)
            XCTAssertTrue(movie?.title == "TestTitle")
            XCTAssertTrue(movie?.overview == "TestOverView")
        }
    }
    func testImagesObjectCreation(){
        if let fanartMockJSONString = self.fanartMockJSONString{
            let jsonObject = JSON(parseJSON: fanartMockJSONString)
            let images = Images.parse(jsonObject: jsonObject)
            XCTAssertNotNil(images)
            XCTAssertTrue(images?.mostLikedMoviePosterUrl == "testURL")
            XCTAssertTrue(images?.mostLikedMovieThumbUrl == "testURL")
        }
    }
    
    var movieMockJSONString : String?{
        guard let productFilePath = Bundle(for: DataTests.self).path(forResource: "movie", ofType: "json") else{
            return nil
        }
        do{
            return try String(contentsOfFile: productFilePath)
        }catch let error{
            print(error)
        }
        return nil
    }
    var fanartMockJSONString : String?{
        guard let productFilePath = Bundle(for: DataTests.self).path(forResource: "fanart", ofType: "json") else{
            return nil
        }
        do{
            return try String(contentsOfFile: productFilePath)
        }catch let error{
            print(error)
        }
        return nil
    }
    
    
}
