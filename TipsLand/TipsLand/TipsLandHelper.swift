//
//  TipsLandHelper.swift
//  TipsLand
//
//  Created by Cjh on 2022/10/9.
//

import UIKit

extension UIApplication {
    static var rootWindow: UIWindow? {
        get {
            guard let window = self.shared.delegate?.window else {
                return nil
            }
            return window
        }
    }
    static var rootViewController: UIViewController? {
        get {
            guard let window = self.rootWindow else {
                return nil
            }
            return window.rootViewController
        }
    }
    static var rootView: UIView? {
        get {
            guard let rootViewController = self.rootViewController else {
                return nil
            }
            return rootViewController.view
        }
    }
    static var safeAreaInsets: UIEdgeInsets? {
        get {
            guard let rootWindow = self.rootWindow else {
                return nil
            }
            return rootWindow.safeAreaInsets
        }
    }
}

extension Bundle {
    static var tipsLandBundle: Bundle {
        get {
            guard let bundleURL = Bundle.main.path(forResource: "TipsLandBundle", ofType: "bundle"),
                  let bundle = Bundle(path: bundleURL)
            else {
                return Bundle.main
            }
            return bundle
        }
    }
}

extension UIColor {
    static func bundleColor(_ name: String) -> UIColor? {
        return UIColor.init(named: name, in: Bundle.tipsLandBundle, compatibleWith: nil)
    }
}
