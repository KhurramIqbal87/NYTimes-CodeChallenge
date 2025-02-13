//
//  BaseTableViewAdapter.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine
import UIKit
// MARK: - ViewLife Cycle protocol
//MARK: - Adapter
protocol BaseTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    associatedtype Model
    var data: [[Model]] { get set}
    var didSelectItem: ((_ indexPath: IndexPath)-> Void)? { get set }
    var didScrollTo: ((_ indexPath: IndexPath)-> Void)? { get set }
    var tableView: UITableView? { get set }
    
    func appendData(data: [Any], at section: Int)
    func updateData(data: [[Any]])
}

extension BaseTableViewAdapter {
    func appendData(data: [Any], at section: Int) { }
    func updateData(data: [[Any]]) { }
}
