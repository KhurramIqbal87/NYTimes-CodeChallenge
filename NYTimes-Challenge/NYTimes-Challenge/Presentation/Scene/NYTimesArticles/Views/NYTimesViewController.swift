//
//  NYTimesViewController.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 10/02/2025.
//

import UIKit
import Combine

class NYTimesViewController<T: NYTImesArticleViewModelType>: BaseViewController<T> {
    //    MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    
    private var cancelables: Set<AnyCancellable> = []
    private var refreshControl = UIRefreshControl()
    private let tableViewAdapter: any BaseTableViewAdapter
    private let coordinator: NYTimesArticleCoordinatorType
    private let viewModel: T

    init (
        _ viewModel: T,
        tableViewAdapter: any BaseTableViewAdapter,
        coordinator: NYTimesArticleCoordinatorType
    ) {
        self.tableViewAdapter = tableViewAdapter
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(T: viewModel, nibName: "NYTimesViewController")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupTableViewAdapter()
        setupViewModel()
    }

    private func setupViewModel() {
        viewModel.loadingPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] show in
                if let show {
                    self?.showLoader(show: show)
                }
            }
            .store(in: &cancelables)
        viewModel.errorPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error {
                    self?.showError(title: "Error", message: error)
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancelables)
        viewModel.itemsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                if let items {
                    self?.tableViewAdapter.updateData(data: [items])
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancelables)
        viewModel.viewDidLoad()
    }

    private func setupTableViewAdapter() {
        tableViewAdapter.tableView = tableView
        tableViewAdapter.didSelectItem = { [weak self] indexPath in
            self?.viewModel.didSelectArticle(at: indexPath)
            self?.coordinator.navigateToDetailController(indexPath: indexPath)
        }
    }
    
    private func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh Data")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not re
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        self.viewModel.refresh()
    }
}
