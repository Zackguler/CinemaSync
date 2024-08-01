//
//  SceneDelegate.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        performSwizzlingMagic()
        startRootCoordinator()
    }
    
    private func performSwizzlingMagic() {
        UIViewController.doBadSwizzleStuff()
    }
    
    func startRootCoordinator() {
        guard let window = self.window else { return }
        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

private var hasSwizzled = false

private func swizzle(_ viewController: UIViewController.Type) {
    let swizzlers = [
        (#selector(viewController.viewWillAppear(_:)), #selector(viewController.devCheck_viewWillAppear(_:)))
    ]
    
    for (original, swizzled) in swizzlers {
        guard let originalMethod = class_getInstanceMethod(viewController, original),
              let swizzledMethod = class_getInstanceMethod(viewController, swizzled) else { continue }
        
        let didAddMethod = class_addMethod(viewController, original, method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(viewController, swizzled, method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

extension UIViewController {
    
    final public class func doBadSwizzleStuff() {
        guard !hasSwizzled else { return }
        hasSwizzled = true
        swizzle(self)
    }
    
    @objc internal func devCheck_viewWillAppear(_ animated: Bool) {
        self.devCheck_viewWillAppear(animated)
        if !self.hasViewAppeared {
            self.applyStyles()
            self.hasViewAppeared = true
        }
        
        if parent is UINavigationController {
            if let firstChild = childForHidesNavigationBarWhenPushed {
                var nextChild: UIViewController? = firstChild
                var hidesNavigationBar = firstChild.hidesNavigationBarWhenPushed

                while nextChild != nil {
                    hidesNavigationBar = nextChild!.hidesNavigationBarWhenPushed
                    nextChild = nextChild!.childForHidesNavigationBarWhenPushed
                }
                navigationController?.setNavigationBarHidden(hidesNavigationBar, animated: animated)

            } else {
                navigationController?.setNavigationBarHidden(hidesNavigationBarWhenPushed, animated: animated)
            }
        }
    }
    
    @objc open func applyStyles() {
    }
    
    @objc open var childForHidesNavigationBarWhenPushed: UIViewController? {
        return nil
    }
    
    @objc open var hidesNavigationBarWhenPushed: Bool {
        return true
    }
    
    private struct AssociatedKeys {
        static var hasViewAppeared = "hasViewAppeared"
    }
    
    private var hasViewAppeared: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.hasViewAppeared) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hasViewAppeared,
                                     newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
