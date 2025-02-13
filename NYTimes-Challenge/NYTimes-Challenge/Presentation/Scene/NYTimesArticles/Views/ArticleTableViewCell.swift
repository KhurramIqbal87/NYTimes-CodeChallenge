//
//  ArticleTableViewCell.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import UIKit

final class ArticleTableViewCell: UITableViewCell, BaseTableViewCell {
    @IBOutlet private (set) weak var imgView: UIImageView?
    @IBOutlet private (set) weak var postedDate: UILabel?
    @IBOutlet private (set) weak var copyRight: UILabel?
    @IBOutlet private (set) weak var title: UILabel?
    @IBOutlet private (set) weak var author: UILabel?
    
    private var viewModel: (any NYTimeArticlesItemViewModelType)? {
        didSet { setupData() }
    }
    
    func setData(data: Any) {
        if let data = data as? (any NYTimeArticlesItemViewModelType) {
            viewModel = data
            viewModel?.imageDownloaded = { [weak self] imageData, id in
                self?.setImage(data: imageData, id: id)
            }
        }
     }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setUI()
        traitCollectionDidChange(nil)
    }
}

private extension ArticleTableViewCell {
     func setupData() {
         imgView?.image = nil
         imgView?.backgroundColor = .clear
         if let imageData = viewModel?.getImageData() {
             imgView?.image = UIImage(data: imageData)
         } else {
             imgView?.backgroundColor = .black
         }
         postedDate?.text = viewModel?.date
         title?.text = viewModel?.title
         author?.text = viewModel?.author
         copyRight?.text = viewModel?.copyRight
     }

    func setUI() {
        imgView?.layer.cornerRadius = 30
        imgView?.layer.masksToBounds = true
        imgView?.clipsToBounds = true
    }
    
    func setImage(data: Data, id: Int) {
        if id == viewModel?.id {
            DispatchQueue.main.async { [weak self] in
                self?.imgView?.image = UIImage(data: data)
            }
        }
    }
}

extension ArticleTableViewCell {
    internal override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark {
            imgView?.backgroundColor = .label
            postedDate?.textColor = .label
            author?.textColor = .label
            copyRight?.textColor = .label
        } else {
            imgView?.backgroundColor = .label
            postedDate?.textColor = .systemGray2
            author?.textColor = .systemGray2
            copyRight?.textColor = .systemGray2
        }
    }
}

extension UITableViewCell {
    static var identifier: String { "\(self)" }
}
