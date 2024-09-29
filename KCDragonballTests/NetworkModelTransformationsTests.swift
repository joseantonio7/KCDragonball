//
//  NetworkModelTransformationsTests.swift
//  KCDragonballTests
//
//  Created by José Antonio Aravena on 29-09-24.
//

import XCTest
@testable import KCDragonball

final class NetworkModelTransformationsTests: XCTestCase {
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<[Transformation]>!
    
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
        sut.token = "test token"
    }

    func test_getHeroes_success() {
        // Given
        let someResult = Result<[Transformation], NetworkError>.success([])
        let hero = Hero(description: "test", name: "Goku", favorite: true, photo: "", id: "1")
        mock.receivedResult = someResult
        var receivedResult: Result<[Transformation], NetworkError>?
        
        // When
        sut.getTransformations(for: hero) { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
}

