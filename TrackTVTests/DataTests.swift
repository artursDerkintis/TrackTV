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
        if let movieMockJSONString = movieMockJSONString{
            let jsonObject = JSON(parseJSON: movieMockJSONString)
            let movie = Movie.parse(jsonObject: jsonObject)
            XCTAssertNotNil(movie)
            XCTAssertTrue(movie?.title == "TestTitle")
            XCTAssertTrue(movie?.overview == "TestOverView")
        }
    }
    
    func testMovieViewModel(){
        if let movieMockJSONString = movieMockJSONString{
            let jsonObject = JSON(parseJSON: movieMockJSONString)
            if let movie = Movie.parse(jsonObject: jsonObject){
                let movieVM = MovieViewModel(movie: movie)
                XCTAssertEqual(movieVM.ratingString, "⭐️ 7.4")
                XCTAssertEqual(movieVM.genres, "Testgenre  ")
                XCTAssertEqual(movieVM.homepageURL, URL(string : "http://www.getoutfilm.com/"))
                XCTAssertEqual(movieVM.trailerURL, URL(string : "http://youtube.com/watch?v=sRfnevzM9kQ"))
                XCTAssertEqual(movieVM.summary, "TestOverView")
                XCTAssertEqual(movieVM.year, "2017")
                XCTAssertEqual(movieVM.tagline, "Test tagline")
                XCTAssertEqual(movieVM.title, "TestTitle")
                
            }
        }
    }
    
}

public var movieMockJSONString : String?{
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
