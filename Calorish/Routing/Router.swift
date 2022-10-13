//
//  Router.swift
//  Calorish
//
//  Created by admin on 23.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol Closable {
    func close(transitionType: TransitionType)
}

protocol RouterProtocol: AnyObject {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get }
    func close(transitionType: TransitionType)
}

class Router<V>: NSObject, RouterProtocol where V: UIViewController {
    
    typealias ViewController = V
    
    var viewController: V?
    
    func close(transitionType: TransitionType) {
        
        switch transitionType {
        case .pop:
            viewController?.navigationController?.popViewController(animated: true)
            
        case .dismiss:
            if let navVC = viewController?.navigationController {
                navVC.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                viewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
