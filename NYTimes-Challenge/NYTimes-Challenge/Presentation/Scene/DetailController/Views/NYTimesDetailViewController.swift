//
//  NYTimesDetailViewController.swift
//  NYTimes-Challenge
//
//  Created by MAC918046 on 12/02/2025.
//

import UIKit
import Combine

final class NYTimesDetailViewController<T: NYTimeArticlesDetailViewModelType>: BaseViewController<T> {
   
    private var viewModel: NYTimeArticlesDetailViewModelType
    private let coordinator: NYTimesArticleDetailCoordinatorType
    @IBOutlet weak private (set) var imgView: UIImageView!
    @IBOutlet weak private (set) var articleTitle: UILabel!
    @IBOutlet weak private (set) var authors: UILabel!
    @IBOutlet weak private (set) var date: UILabel!
    @IBOutlet weak private (set) var copyRight: UILabel!
    @IBOutlet weak private (set) var url: UILabel!
    private var cancelables: Set<AnyCancellable> = []
    
    init(
        viewModel: T,
        coordinator: NYTimesArticleDetailCoordinatorType
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(T: viewModel, nibName: "NYTimesDetailViewController")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.viewDidLoad()
        traitCollectionDidChange(nil)
    }
    
    
    private func setupViewModel() {
        viewModel.imageDataPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] data in
                self?.updateImage(data: data)
            })
            .store(in: &cancelables)
        viewModel.updateUI = { [weak self] in
            self?.updateUIData()
        }
    }
    private func updateUIData() {
        articleTitle.text = viewModel.articleTile
        authors.text = viewModel.author
        copyRight.text = viewModel.copyRight
        date.text = viewModel.date
        url.text = viewModel.url
    }
    
    private func updateImage(data: Data?) {
        if let data {
            imgView.image = UIImage(data: data)
        }
    }
    
   
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark {
            articleTitle.textColor = .label
            authors.textColor = .label
            copyRight.textColor = .label
            date.textColor = .label
            url.textColor = .label
        } else {
            articleTitle.textColor = .label
            authors.textColor = .darkText
            copyRight.textColor = .darkText
            date.textColor = .darkText
            url.textColor = .darkText
        }
        
    }
    
    deinit {
        coordinator.didNavigateBack()
    }
}
