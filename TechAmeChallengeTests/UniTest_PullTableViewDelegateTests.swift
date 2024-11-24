//
//  UniTest_PullTableViewDelegateTests.swift
//  TechAmeChallengeTests
//
//  Created by Henrique on 24/11/24.
//

import XCTest

@testable import TechAmeChallenge

final class UniTest_PullTableViewDelegateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PullTableViewDelegate_modifyString_shouldReturnURL(){
        //given
        let url = "https://api.github.com/repos/Alamofire/Alamofire/issues/3917"
        let correctUrl = "https://github.com/Alamofire/Alamofire/issues/3917"
        //when
        let pulldelegate = PullTableViewDelegate(pulls: [], navigationController: UINavigationController())
        let modifyString = pulldelegate.modifyString(url: url)
        //then
        
        XCTAssertEqual(modifyString, correctUrl)
        
    }

}
