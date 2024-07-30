//
//  BaseCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

open class BaseCoordinator: NSObject, AnyCoordinator {
    open var rootViewController: UIViewController {
        fatalError("Subclasses must override and not call super")
    }
    
    public final var children: [AnyCoordinator?] = []
    
    public final weak var parent: AnyCoordinator?
    
    open var name: String? { return nil }
    
    open func start() { }
    
    open func start(child: AnyCoordinator) {
        child.parent = self
        children.append(child)
        child.start()
    }
    
    open func child(_ child: AnyCoordinator, didCompleteWithReason reason: CoordinatorCompletionReason) {
        remove(child: child)
    }
    
    final func remove(child: AnyCoordinator) {
        guard let index = children.firstIndex(where: { $0 === child }) else { return }
        children.remove(at: index)
    }
    
    func removeAllChildren() {
        for var child in children {
            if let child = child {
                if let navigation = child.rootViewController as? UINavigationController {
                    navigation.popToRootViewController(animated: false)
                    navigation.dismiss(animated: false)
                }
                self.remove(child: child)
            }
            if let child = child as? BaseCoordinator {
                child.deInitialize()
            }
            child = nil
        }
    }
    
    open func deInitialize() {
        self.removeAllChildren()
        if let navigation = self.rootViewController as? UINavigationController {
            navigation.popToRootViewController(animated: false)
            navigation.dismiss(animated: false)
        }
    }
}
