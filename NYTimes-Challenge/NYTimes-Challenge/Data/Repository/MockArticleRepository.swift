//
//  MockArticleRepository.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 13/02/2025.
//

import Foundation
import Combine

final class MockArticleRepository: ArticleRepositoryType {
    
   func getArticles(completion: @escaping (Result<[NYTimesArticle], APIError>) -> Void) {
       completion(.success(getNytimeArticles()))
    }

    private func getNytimeArticles()-> [NYTimesArticle] {
        
         let nytimeArticle1 = NYTimesArticle(
             id: 1234,
             title: "Test 1 title",
             abstract: "test 1 abstract",
             published_date: "13-feb-25",
             section: "test",
             byline: "By khurram, xyz",
             source: "Test Source 1",
             adx_keywords: "test",
             url: "https://www.google.com",
             media: [Media(
                 type: .image,
                 copyright: "test",
                 mediaMetaData: [MediaMetadata(
                     url: "https://static01.nyt.com/images/2025/02/11/multimedia/09superbowlads-bvhf/09superbowlads-bvhf-mediumThreeByTwo440.jpg",
                     height: 293,
                     width: 440,
                     format: .large
                 ), MediaMetadata(
                  url: "https://static01.nyt.com/images/2025/02/11/multimedia/09superbowlads-bvhf/09superbowlads-bvhf-mediumThreeByTwo210.jpg",
                  height: 140,
                  width: 210,
                  format: .medium
                 ),MediaMetadata(
                  url: "https://static01.nyt.com/images/2025/02/11/multimedia/09superbowlads-bvhf/09superbowlads-bvhf-thumbStandard.jpg",
                  height: 75,
                  width: 75,
                  format: .thumbnail
                 )]
             )]
         )
        let nytimeArticle2 = NYTimesArticle(
            id: 1234,
            title: "Test 2 title",
            abstract: "test 2 abstract",
            published_date: "14-feb-25",
            section: "test",
            byline: "By khurram, xyz",
            source: "Test Source 2",
            adx_keywords: "test",
            url: "https://www.google.com",
            media: [Media(
                type: .image,
                copyright: "test",
                mediaMetaData: [MediaMetadata(
                    url: "https://static01.nyt.com/images/2025/02/10/multimedia/10nat-freeze-order-gzcp/10nat-freeze-order-gzcp-mediumThreeByTwo440.jpg",
                    height: 293,
                    width: 440,
                    format: .large
                ), MediaMetadata(
                 url: "https://static01.nyt.com/images/2025/02/10/multimedia/10nat-freeze-order-gzcp/10nat-freeze-order-gzcp-mediumThreeByTwo210.jpg",
                 height: 140,
                 width: 210,
                 format: .medium
                ),MediaMetadata(
                 url: "https://static01.nyt.com/images/2025/02/10/multimedia/10nat-freeze-order-gzcp/10nat-freeze-order-gzcp-thumbStandard.jpg",
                 height: 75,
                 width: 75,
                 format: .thumbnail
                )]
            )]
        )
        return[nytimeArticle1, nytimeArticle2]
    }
    
}
