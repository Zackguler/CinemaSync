//
//  MovieSearchViewController.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //    MARK: - Variables
    
    var viewModel: HomeViewModel
    
    //    MARK: - UI Elements
    
    private lazy var headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        return view
    }()
    
    private lazy var sectionsTableView: UITableView = {
        let tableVw = UITableView()
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.tableHeaderView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: 500, height: 60))
        tableVw.register(MoviesSectionsCell.self, forCellReuseIdentifier: MoviesSectionsCell.reuseIdentifier)
        tableVw.separatorStyle = .none
        return tableVw
    }()
    
    //    MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //    MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(sectionsTableView)
        layout()
    }
}

//    MARK: - Layout

extension HomeViewController {
    private func layout() {
        sectionsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

//    MARK: - TableView Delegate and DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MoviesSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MoviesSections(rawValue: indexPath.section),
              let cell = tableView.dequeueReusableCell(withIdentifier: MoviesSectionsCell.reuseIdentifier, for: indexPath) as? MoviesSectionsCell else {
            return UITableViewCell()
        }
        let movies = viewModel.cellForRowAt(for: section)
        cell.configure(with: movies)
        cell.setTitle(section.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
