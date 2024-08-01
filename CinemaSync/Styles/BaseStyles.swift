//
//  BaseStyles.swift
//  CinemaSync
//
//  Created by Semih Güler on 1.08.2024.
//

import UIKit

public func baseLabelStyle(_ label: UILabel, withFontSize fontSize: CGFloat = 16, color: UIColor? = nil, newFont: Bool = false) {
     label.textColor = color ?? .black
     label.backgroundColor = .clear
     label.font = UIFont.regularInter(ofSize: fontSize)
     label.adjustsFontSizeToFitWidth = true
}

public func baseBoldLabelStyle(_ label: UILabel, withFontSize fontSize: CGFloat = 16, color: UIColor? = nil, newFont: Bool = false) {
     label.textColor = color ?? .black
     label.backgroundColor = .clear
     label.font = UIFont.boldInter(ofSize: fontSize)
     label.adjustsFontSizeToFitWidth = true
}

extension UIFont {
     
     static func regularInter(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
          return UIFont(name: "Inter-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
     }
     
     static func boldInter(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
          return UIFont(name: "Inter-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
     }
}
