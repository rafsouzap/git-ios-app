//
//  UIViewControllerExtension.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation
import UIKit

private var loadingView: UIView = UIView()
private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

extension UIViewController {
    
    func showActivityIndicator() {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            loadingView.frame = window.frame
            loadingView.center = window.center
            loadingView.backgroundColor = UIColor(hexadecimal: 0x000000).withAlphaComponent(0.5)
            loadingView.clipsToBounds = true
            loadingView.alpha = 1
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.style = .large
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
            
            DispatchQueue.main.async {
                loadingView.addSubview(activityIndicator)
                window.addSubview(loadingView)
            }
            
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                loadingView.alpha = 0
            }, completion: { _ in
                loadingView.removeFromSuperview()
            })
        }
    }
    
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }

}
