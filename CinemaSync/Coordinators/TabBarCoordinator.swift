//
//  TabBarCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    private lazy var navigationController = UINavigationController()
    
    private lazy var tabBarController: MainTabbarController = {
        let tabBarVC = MainTabbarController()
        return tabBarVC
    }()
    
    private var tabCoordinators: [AnyCoordinator?] = []
    
    override var rootViewController: UIViewController {
         return tabBarController
    }
    
    override func start() {
        super.start()
        tabCoordinators.forEach { coordinator in
            if let coordinator = coordinator {
                coordinator.rootViewController.navigationController?.popToRootViewController(animated: false)
                coordinator.start()
            }
        }
    }
    
    override init() {
         super.init()
        setupTabCoordinators()
    }
    
    func setupTabCoordinators() {
        deInitialize()
        self.children = []
        tabBarController.viewControllers?.forEach {
            $0.removeFromParent()
        }
        for var child in tabCoordinators {
            if let child = child {
                if let navigation = child.rootViewController as? UINavigationController {
                    navigation.popToRootViewController(animated: false)
                    navigation.dismiss(animated: false)
                }
                if let baseCoordinator = child as? BaseCoordinator {
                    baseCoordinator.deInitialize()
                }
                self.remove(child: child)
            }
            child = nil
        }
        tabCoordinators = []
        var newCoordinators: [AnyCoordinator]
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
        newCoordinators = [homeCoordinator]
        self.tabBarController.viewControllers = newCoordinators.map { $0.rootViewController }
        self.tabCoordinators = newCoordinators
    }
}
