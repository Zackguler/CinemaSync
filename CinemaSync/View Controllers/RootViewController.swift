//
//  RootViewController.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

final class RootViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        }
        return .lightContent
    }
}
