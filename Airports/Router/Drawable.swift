//
//  Drawable.swift
//  Airports
//
//  Created by Maksim  on 14.10.2022.
//

import Foundation
import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
    
    
}
