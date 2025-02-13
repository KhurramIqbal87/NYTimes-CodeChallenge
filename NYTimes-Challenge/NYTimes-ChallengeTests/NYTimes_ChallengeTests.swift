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
        wait(for: [expectation], timeout: 20)
    }
    func testPullToRefresh () {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        // This should load data and show isLoading true and pass the stream value or error if any
        let expectation = XCTestExpectation.init(description: "Should reload data and item count should no be doubled")
        sut.refresh()
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { items in
                if let items,
                   items.count == 20 {
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
        wait(for: [expectation], timeout: 20)
    }
 
    func testObjectForDetailController() {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        sut.refresh()
        let expectation = XCTestExpectation.init(description: "Should give object for detail controller")
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self]  items in
        
                if let items,
                   let _ = self?.sut.getModelForDetailController(
                    indexPath: IndexPath(row: items.count - 1, section: 0)
                ) {
                    XCTAssert(true)
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
        wait(for: [expectation], timeout: 20)
    }
    
    func testNilObjectOrCrashPreventForDetailController() {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        sut.refresh()
        let expectation = XCTestExpectation.init(description: "Should return nil for index beyond and should not crash index beyond limit")
        sut.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self]  items in
                if let items,
                   self?.sut.getModelForDetailController(indexPath: IndexPath(row: items.count, section: 0)) == nil {
                    XCTAssert(true)
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
        wait(for: [expectation], timeout: 20)
    }
    
    func testNoInternetConnection() {
        sut = NYTimesArticleContainer().getArticlesViewModel()
        sut.refresh()
        let expectation = XCTestExpectation.init(description: "should give no internet Connect Error")
        sut.errorPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { errorMsg in
                if let errorMsg,
                   errorMsg == APIError.noInternet.localizedDescription {
                    expectation.fulfill()
                }
            })
            .store(in: &cancelables)
        wait(for: [expectation], timeout: 20)
    }

}
