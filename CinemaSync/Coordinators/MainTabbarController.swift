//
//  MainTabbarController.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

protocol TabbarDelegate: AnyObject {
     func indexWillChange()
     func indexDidChange()
}

class MainTabbarController: UITabBarController {
    
    internal weak var tabbarDelegate: TabbarDelegate!
    
    override var selectedIndex: Int {
        willSet {
            tabbarDelegate.indexWillChange()
        }
        didSet {
            tabbarDelegate.indexDidChange()
        }
    }
    
    override var selectedViewController: UIViewController? {
        willSet {
            tabbarDelegate.indexWillChange()
        }
        didSet {
            tabbarDelegate.indexDidChange()
        }
    }
}
