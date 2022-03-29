//
//  RandomizePromptTests.swift
//  BlankSpaceTests
//
//  Created by Bryan Khufa on 05/10/21.
//

import XCTest
@testable import BlankSpace

class RandomizePromptTests: XCTestCase {

    var sut: RandomizePromptViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
//    func testContextualizedPrompt() {
//        // Testing the init with only 1 filter
//        let expectedCategory1 = PromptCategory.negative
//        sut = RandomizePromptViewModel(context: [.negative])
//
//        for item in sut.contextualizedPrompt {
//            XCTAssertTrue(item.category == expectedCategory1)
//        }
//
//        // Testing the init with 2 filter
//        let expectedCategory2 = PromptCategory.negative
//        sut.contextualPrompt(things: [.positive])
//        for item in sut.contextualizedPrompt {
//            XCTAssertTrue(item.category == expectedCategory1 || item.category == expectedCategory2)
//        }
//    }
}
