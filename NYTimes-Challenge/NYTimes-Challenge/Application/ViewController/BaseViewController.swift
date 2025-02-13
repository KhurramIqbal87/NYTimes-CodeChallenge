//
//  BaseViewController.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 10/02/2025.
//

import UIKit

class BaseViewController<T: NYTimesBaseControllerViewModel>: UIViewController {
    
    //MARK: - StoredProperties
    
    let baseViewModel: T
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator =  UIActivityIndicatorView.init(frame: self.view.frame)
        activityIndicator.style = .large
        activityIndicator.color = .red
        return activityIndicator
    }()
    
    //MARK: - ViewLifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.activityIndicator)
        title = baseViewModel.title
    }
    
    //MARK: - Initializers
    init(T: T, nibName: String?){
        self.baseViewModel = T
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}

//MARK: - Helper Functions
extension BaseViewController{
    func showError(title: String?, message: String?){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) {[weak alertController] _ in
            alertController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoader(show: Bool){
        DispatchQueue.main.async { [weak self] in
            show ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
    }
}
