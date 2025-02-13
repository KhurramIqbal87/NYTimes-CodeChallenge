//
//  NYTimeArticlesItemViewModel.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

class NYTimeArticlesItemViewModel: NYTimeArticlesItemViewModelType {
    
    static func == (lhs: NYTimeArticlesItemViewModel, rhs: NYTimeArticlesItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id: Int { data.id }
    var title: String { data.title }
    var date: String { data.published_date }
    var details: String { data.abstract }
    var author: String { data.byline.components(separatedBy: ",").first ?? "" }
    var copyRight: String { data.source }
    var identifier: String
    var imageDownloaded: ((_ data: Data, _ id: Int) -> Void)?
    //MARK: - Private properties
    private var isDownloading: Bool = false
    @Published private var imageData: Data?
    private var data: NYTimesArticle
    private var repo: ImageRepositoryType
    private var imageUrl: String {
        let mediaMetaData = data.media.first(where: { $0.type == .image })?.mediaMetaData
        return mediaMetaData?.first(where: { $0.format == .thumbnail })?.url ?? ""
    }
    //MARK: - Initializer
    init(
        data: NYTimesArticle,
        identifier: String,
        imageRepo: ImageRepositoryType
        
    ) {
        self.data = data
        self.identifier = identifier
        repo = imageRepo
    }
    
    func getImageData() -> Data? {
        guard let imageData else {
            downloadImage()
            return nil
        }
        return imageData
    }
    
    private func downloadImage(){
        isDownloading = true
        repo.getImageForArticle(imageURL: imageUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let data else { return }
                self.imageData = data
                self.imageDownloaded?(data, self.id)
            case .failure(_): return
            }
            self.isDownloading = false
        }
    }
}
