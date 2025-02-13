//
//  NYTImesArticleUseCase.swift
//  NYTimes-Test
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine
import UIKit

class ArtilesTableViewAdapter<C: BaseTableViewCell, M: NYTimeArticlesItemViewModelType>: NSObject, BaseTableViewAdapter {
    typealias Model = M
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    
    var data: [[Model]] {
        didSet {
            registerNibs()
            tableView?.reloadData()
        }
    }
    var didSelectItem: ((_ indexPath: IndexPath)-> Void)?
    var didScrollTo: ((_ indexPath: IndexPath)-> Void)?
    
    init (data: [[Model]],
          tableView: UITableView?
    ) {
        self.data = data
        self.tableView = tableView
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.estimatedRowHeight = 100
    }
        
    func updateData(data: [[Any]]) {
        if let data = data as? [[M]] { self.data = data }
    }

    //MARK: TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: data[indexPath.section][indexPath.row].identifier,
            for: indexPath
        )
        guard let customTypeCell = cell as? C else { return cell }
        customTypeCell.setData(data: data[indexPath.section][indexPath.row])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int { data.count }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(title: data[section].first?.section)
  
    }
     
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        didScrollTo?(indexPath)
    }
}

extension ArtilesTableViewAdapter {
    private func registerNibs() {
        let nibs = Set(data.flatMap { $0 })
        for item in nibs {
            let cellNib = UINib(nibName: item.identifier, bundle: .main)
            tableView?.register(cellNib, forCellReuseIdentifier: item.identifier)
        }
    }
    private func createHeaderView(title: String?) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGray5
        
        // Create a label for the header
        let headerLabel = UILabel()
        headerLabel.text = title
        headerLabel.textColor = .label
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Add label to header view
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        // Set constraints for the label
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }
}
