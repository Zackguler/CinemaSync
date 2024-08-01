//
//  HomeCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    private lazy var navigationController = UINavigationController()
    
    var movieSearchCoordinator: HomeViewCoordinator?
    
    override func start() {
        super.start()
        restartCoordinators()
    }
    
    override var rootViewController: UIViewController {
         return navigationController
    }
    
    private func restartCoordinators() {
        movieSearchCoordinator = HomeViewCoordinator(navigationController: navigationController)
         if let movieSearchCoordinator = movieSearchCoordinator {
             movieSearchCoordinator.parent = self
              navigationController.setViewControllers([movieSearchCoordinator.rootViewController], animated: false)
              self.start(child: movieSearchCoordinator)
         }
    }
}
