//
//  RouterProtocol.swift
//  Airports
//
//  Created by Maksim  on 14.10.2022.
//

import Foundation

typealias NavigationBackClosure = (() -> Void)

protocol Routing {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: NavigationBackClosure?)
}
