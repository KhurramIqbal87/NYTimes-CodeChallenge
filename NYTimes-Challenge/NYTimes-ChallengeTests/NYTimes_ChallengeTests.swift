//
//  NYTimes_ChallengeTests.swift
//  NYTimes-ChallengeTests
//
//  Created by MAC918046 on 11/02/2025.
//

import XCTest
import Combine
@testable import NYTimes_Challenge

final class NYTimes_ChallengeTests: XCTestCase {
    var sut: NYTImesArticleViewModelType!
    var cancelables: Set<AnyCancellable> = []
    var itemCount = 0
    
    override func setUp() {
       
        super.setUp()
        sut = NYTimesArticleContainer().getArticlesViewModel()
    }
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad (){
        // This should load data and show isLoading true and pass the stream value or error if any
        var loading = false
        let expectation = XCTestExpectation.init(description: "Should load data and count should be greater than 0")
        sut.viewDidLoad()
        sut.loadingPublisher
            .receive(on: RunLoop.main)
            .sink { dataloading in
                guard let dataloading,
                      loading != dataloading else {
                    XCTAssert(false)
                    expectation.fulfill()
                    return
                }
                loading = dataloading
            }
            .store(in: &cancelables)
            
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] items in
                if let items, items.count > 0 {
                    self?.itemCount = items.count
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
        wait(for: [expectation], timeout: 10)
    }
    func testPullToRefresh () {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        // This should load data and show isLoading true and pass the stream value or error if any
        let expectation = XCTestExpectation.init(description: "Should reload data and item count should no be doubled")
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self]  items in
                if let items,
                   items.count > 0,
                   items.count == self?.itemCount {
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
        wait(for: [expectation], timeout: 10)
    }
 
    func testObjectForDetailController() {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        sut.refresh()
        let expectation = XCTestExpectation.init(description: "Should give object for detail controller")
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self]  items in
                guard let items else {
                    XCTAssert(false)
                    expectation.fulfill()
                    return
                }
                if let _ = self?.sut.getModelForDetailController(
                    indexPath: IndexPath(row: items.count - 1, section: 0)
                ) {
                    XCTAssert(true)
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
    }
    
    func testNilObjectForDetailController() {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        sut.refresh()
        let expectation = XCTestExpectation.init(description: "Should return nil for index beyond")
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self]  items in
                guard let items else {
                    XCTAssert(false)
                    expectation.fulfill()
                    return
                }
                if self?.sut.getModelForDetailController(indexPath: IndexPath(row: items.count, section: 0)) == nil {
                    XCTAssert(true)
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
