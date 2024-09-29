//
//  NetworkModelLoginTests.swift
//  KCDragonballTests
//
//  Created by José Antonio Aravena on 29-09-24.
//

import XCTest
@testable import KCDragonball

final class NetworkModelLoginTests: XCTestCase {
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<String>!
    
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
        sut.token = "test token"
    }
    func test_login_success() {
        //Given
        let someResult = Result<String, NetworkError>.success("test token")
        mock.receivedResult = someResult
        var receivedResult: Result<String, NetworkError>?
        let user = "goku@dragonball.com"
        let password = "goku7"
        
        // When
        sut.login(user: user , password: password) { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
    func test_login_faliure() {
        //Given
        let someResult = Result<String, NetworkError>.failure(.malformedURL)
        mock.receivedResult = someResult
        var receivedResult: Result<String, NetworkError>?
        let user = "goku@dragonball.com"
        let password = "goku7"
        
        // When
        sut.login(user: user , password: password) { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
}

