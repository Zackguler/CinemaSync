//
//  ChildPresenter.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit
import SnapKit

protocol ChildPresenter {
     func addFullScreen(parent:UIViewController, child: UIViewController)
     func afterFullScreen()
     func removeFullScreen(child: UIViewController)
     func afterRemoveScreen()
}

extension ChildPresenter {
     func addFullScreen(parent:UIViewController, child: UIViewController) {
          parent.addChild(child)
          parent.view.addSubview(child.view)

          child.view.snp.remakeConstraints {
               $0.top.left.right.bottom.equalToSuperview()
          }
          
          child.didMove(toParent: parent)
          self.afterFullScreen()
     }
     
     func removeFullScreen(child: UIViewController) {
          child.willMove(toParent: nil)
          child.view.removeFromSuperview()
          child.removeFromParent()
          self.afterRemoveScreen()
     }
     
     func getNavigationController() -> UINavigationController {
          guard let viewController = self as? UIViewController else { return UINavigationController() }
          if let navigation = viewController.navigationController {
               return navigation
          }
          return UINavigationController()
     }
}
