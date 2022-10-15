//
//  Router.swift
//  Airports
//
//  Created by Maksim  on 14.10.2022.
//

import Foundation
import UIKit

final class Router: NSObject {
    
    private let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
        
    }
    
}

extension Router: Routing {
  
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func executeClosures(_ viewController: UIViewController) -> Void {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
    
    func popToRoot(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        navigationController.present(viewController, animated: isAnimated)
        viewController.presentationController?.delegate = self
    }
    
}

extension Router: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosures(presentationController.presentedViewController)
    }
    
}


extension Router: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        guard !navigationController.viewControllers.contains(previousController) else { return }
        
        executeClosures(previousController)
    }
}
