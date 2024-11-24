//
//  UnitTest_EndpointTests.swift
//  TechAmeChallengeTests
//
//  Created by Henrique on 24/11/24.
//

import XCTest

@testable import TechAmeChallenge

final class UnitTest_EndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Endpoint_fetchRepo_shouldReturnURL(){
        //given
        let page = 5
        let url = URL(string: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(page)")
        
        let url2 = URL(string: "https://api.github.com/test/tesst?q=language:Swift&sort=stars&page=\(page)")
        
        //when
        let endpoint = Endpoint.fetchRepo(page: page.formatted())
        let request = URLRequest(url: url!)
        
        let endpoint2 = Endpoint.fetchRepo(url: "/test/tesst", page: page.formatted())
        let request2 = URLRequest(url: url2!)
        
        //then
        XCTAssertEqual(endpoint.request, request)
        XCTAssertEqual(endpoint2.request, request2)
    }
    
    func test_Endpoint_fetchPull_shouldReturnURL(){
        //given
        let name = "topSwift"
        let user = "henrique"
        let url = URL(string: "https://api.github.com/search/issues?q=repo:\(user)/\(name)+type:pr+state:open")
        let url2 = URL(string: "https://api.github.com/seila/seila?q=repo:\(user)/\(name)+type:pr+state:open")
        
        //when
        let endpoint = Endpoint.fetchPull(user: user, name: name)
        let request = URLRequest(url: url!)
        
        let endpoint2 = Endpoint.fetchPull(url: "/seila/seila", user: user, name: name)
        let request2 = URLRequest(url: url2!)
        
        //then
        XCTAssertEqual(endpoint.request, request)
        XCTAssertEqual(endpoint2.request, request2)
    }
    

}
