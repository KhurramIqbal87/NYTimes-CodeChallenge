//
//  NYTimes_ChallengeTests.swift
//  NYTimes-ChallengeTests
//
//  Created by MAC918046 on 11/02/2025.
//

import XCTest
import Combine
@testable import NYTimes_Challenge

final class NYTimesDetailViewModelTests: XCTestCase {
    var sut: NYTimeArticlesDetailViewModelType!
    var cancelables: Set<AnyCancellable> = []
    var itemCount = 0
    
    override func setUp() {
       
        super.setUp()
        createViewModel()
    }
    
    func createViewModel() {
        let repo = MockImageRepository()
        let expectation = XCTestExpectation.init(description: " should load mock data ")
        MockArticleRepository().getArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.sut = NYTimesArticleDetailContainer().createMockRepoViewModel(article: articles[0])
                expectation.fulfill()
                
            case .failure(_):
                XCTAssert(false)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad () {
        sut.viewDidLoad()
        let updatUIExpectation = XCTestExpectation.init(description: " should callback to update ")
        sut.updateUI = {
            updatUIExpectation.fulfill()
        }
        let imageDataExpectation = XCTestExpectation.init(description: " should provide mock image")
        sut.imageDataPublisher
            .receive(on: RunLoop.main)
            .sink { data in
                if let _ = data { imageDataExpectation.fulfill() }
            }
            .store(in: &cancelables)
        wait(for: [updatUIExpectation, imageDataExpectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
