//
//  PromptTests.swift
//  BlankSpaceTests
//
//  Created by Bryan Khufa on 04/10/21.
//

import XCTest
@testable import BlankSpace

class PromptTests: XCTestCase {
    
    var sut: [Prompt]!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = ModelData.loadJson("prompt.json")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
//    func testLoadJson() {
//        let firstPrompt = sut[0]
//        XCTAssertEqual(firstPrompt.id, "1")
//        XCTAssertEqual(firstPrompt.text, "Lorem ipsum")
//        XCTAssertEqual(firstPrompt.category, .family)
//        XCTAssertEqual(sut.count, 7)
//    }
}
