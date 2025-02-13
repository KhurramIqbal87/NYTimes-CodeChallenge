//
//  NYTimesItemViewModelTests.swift
//  NYTimes-ChallengeTests
//
//  Created by MAC918046 on 11/02/2025.
//

import XCTest
import Combine
@testable import NYTimes_Challenge

final class NYTimesItemViewModelTests: XCTestCase {
    
    var cancelables: Set<AnyCancellable> = []
    var sut: (any NYTimeArticlesItemViewModelType)!
    
    override func setUp() {
        super.setUp()
    }
    
    func testItemViewModel() {
        let articleVM = NYTimesArticleContainer().getMockRepoArticlesViewModel()
        let expectation = XCTestExpectation.init(description: " title Test 1 title")
        let imageExpectation = XCTestExpectation.init(description: " Should notify when image is downloaded")
        articleVM.itemsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                if let items,
                   items.first?.title == "Test 1 title" {
                    self?.sut = items.first
                    self?.getImage { data in
                        imageExpectation.fulfill()
                    }
                    expectation.fulfill()
                }
            }
            .store(in: &cancelables)
        articleVM.refresh()
        wait(for: [expectation, imageExpectation], timeout: 20)
    }
    func getImage(completion : @escaping ((_ imageData: Data)->Void)) {
        sut.imageDownloaded = { (data, id) in
            completion(data)
        }
        let data = sut.getImageData()
        if let data {
            completion(data)
        }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    
   
  

}
