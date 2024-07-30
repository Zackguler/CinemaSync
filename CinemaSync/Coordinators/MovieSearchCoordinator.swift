//
//  MovieSearchCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

final class MovieSearchCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    
    var _rootViewController: MovieSearchViewController?
    
    override var rootViewController: UIViewController {
        if let vc = _rootViewController {
            return vc
        } else {
            return UIViewController()
        }
    }
    
    override func deInitialize() {
         super.deInitialize()
         _rootViewController = nil
    }
    
    init(navigationController: UINavigationController) {
         self.navigationController = navigationController
         super.init()
         self.setRootViewController()
    }
    
    func setRootViewController() {
         self._rootViewController = MovieSearchViewController()
    }
}
