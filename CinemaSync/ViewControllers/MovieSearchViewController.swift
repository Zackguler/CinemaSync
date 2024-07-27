//
//  MovieSearchViewController.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

class MovieSearchViewController: UIViewController {
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
