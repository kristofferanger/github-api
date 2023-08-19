//
//  github_apiTests.swift
//  github-apiTests
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import XCTest
@testable import github_api

final class github_apiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthorization() throws {
        // check if autorization is added correctly to the request
        // ["Accept": "application/vnd.github+json", "Authorization": "Bearer \(token)", "X-GitHub-Api-Version": "2022-11-28"]
        let request = NetworkManager.headerTestRequest
        let value = request.value(forHTTPHeaderField: "Authorization")
        // auth header exists
        XCTAssertNotNil(value)
        // test if auth keyword is included
        XCTAssert(value!.hasPrefix("Bearer"))
        // test if token is added
        XCTAssertNotNil(value!.split(separator: " ").last)
        XCTAssert(value!.split(separator: " ").last!.count > 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
