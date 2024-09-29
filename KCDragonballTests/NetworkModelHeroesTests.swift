//
//  NetworkModelHeroesTests.swift
//  NetworkModelHeroesTests
//
//  Created by José Antonio Aravena on 28-09-24.
//

import XCTest
@testable import KCDragonball

final class NetworkModelHeroesTests: XCTestCase {
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<[Hero]>!
    
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
        sut.token = "test token"
    }

    func test_getHeroes_success() {
        // Given
        let someResult = Result<[Hero], NetworkError>.success([])
        mock.receivedResult = someResult
        var receivedResult: Result<[Hero], NetworkError>?
        
        // When
        sut.getHeroes { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
    func test_getHeroes_faliure() {
        // Given
        let someResult = Result<[Hero], NetworkError>.failure(.noData)
        mock.receivedResult = someResult
        var receivedResult: Result<[Hero], NetworkError>?
        
        // When
        sut.getHeroes { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
}
