//
//  HomeCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    private lazy var navigationController = UINavigationController()
    
    var homeCoordinator: HomeViewCoordinator?
    
    override func start() {
        super.start()
        restartCoordinators()
    }
    
    override var rootViewController: UIViewController {
         return navigationController
    }
    
    private func restartCoordinators() {
        homeCoordinator = HomeViewCoordinator(navigationController: navigationController)
         if let homeCoordinator = homeCoordinator {
             homeCoordinator.parent = self
              navigationController.setViewControllers([homeCoordinator.rootViewController], animated: false)
              self.start(child: homeCoordinator)
         }
    }
}
