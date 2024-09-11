//
//  UIView+Extensions.swift
//  CinemaSync
//
//  Created by Semih Güler on 1.08.2024.
//

import UIKit

extension UIView {

    @objc open func applyStyles() { }

    @objc public static var reuseIdentifier: String {
        return nibName
    }

    public static var nibName: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
