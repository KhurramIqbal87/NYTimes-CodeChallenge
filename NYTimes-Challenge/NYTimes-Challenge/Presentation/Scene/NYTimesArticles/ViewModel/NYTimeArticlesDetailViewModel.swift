//
//  NYTimeArticlesDetailViewModel.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine


class NYTimeArticlesDetailViewModel: NYTimeArticlesDetailViewModelType {
    var title: String? { "Article Detail"}
    var articleTile: String { "Title: " + article.title }
    var date: String { "Posted Date: " + article.published_date }
    var details: String { "Abstract: " + article.abstract }
    var url: String {"Full Details URL: " + article.url}
    var author: String { "Authors: " + article.byline }
    var copyRight: String { "Copyrights: " + article.source }
    var updateUI: VoidClosure?
    var imageDataPublisher: Published<Data?>.Publisher{ $imageData}
    
    private var article: NYTimesArticle
    private var imageRepository: ImageRepositoryType
    @Published private var imageData: Data?
    
    init(
        article: NYTimesArticle,
        repository: ImageRepositoryType
    ) {
        self.article = article
        self.imageRepository = repository
    }
    
    func viewDidLoad() {
        loadImageData()
        updateUI?()
    }
    
    private func loadImageData() {
        let mediaMetaData = article.media.first(where: { $0.type == .image } )?.mediaMetaData
        if let mediaUrl = mediaMetaData?.first(where: { $0.format == .large })?.url {
            imageRepository.getImageForArticle(imageURL: mediaUrl) { [weak self] result in
                self?.handleImageResponse(result: result)
            }
        }
    }
    
    private func handleImageResponse(result: Result<Data?, APIError>) {
        switch result {
        case .success(let data):
            imageData = data
        default: break
        }
    }
}
