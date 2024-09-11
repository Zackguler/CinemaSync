//
//  SeeAllMoviesViewController.swift
//  CinemaSync
//
//  Created by Semih Güler on 9.08.2024.
//

import UIKit

protocol SeeAllMoviesDelegate: AnyObject {
    func didTapClose(_ viewController: SeeAllMoviesViewController)
}

class SeeAllMoviesViewController: UIViewController {
    
    weak var delegate: SeeAllMoviesDelegate?
    
    var viewModel: SeeAllMoviesViewModel
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        return indicator
    }()
    
    private lazy var closeImage: UIImageView = {
        let image = UIImage(named: "close-icon")?.withRenderingMode(.alwaysTemplate)
        let imageVw = UIImageView(image: image)
        imageVw.tintColor = .black
        imageVw.isUserInteractionEnabled = true
        imageVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapClose)))
        return imageVw
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 2 - 30, height: view.frame.width / 2 * 1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularAndUpcomingMovieCell.self, forCellWithReuseIdentifier: PopularAndUpcomingMovieCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "movieCell")
        return tableView
    }()
    
    //    MARK: - Init
    
    init(viewModel: SeeAllMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(closeImage)
        closeImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(24)
        }
        switch viewModel.sectionType {
        case .topRated:
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.top.equalTo(closeImage.snp.bottom).offset(16)
                make.left.right.bottom.equalToSuperview().inset(24)
            }
        default:
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(closeImage.snp.bottom).offset(16)
                make.left.right.bottom.equalToSuperview().inset(24)
            }
        }
    }
    
    @objc private func didTapClose() {
        delegate?.didTapClose(self)
    }
    
    //    MARK: - Lifecycle
    
    override func bindViewModel() {
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.onMoviesLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.setupViews()
                self?.collectionView.reloadData()
                self?.tableView.reloadData()
            }
        }
    }
}

extension SeeAllMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.movieCount)
        return viewModel.movieCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularAndUpcomingMovieCell.reuseIdentifier, for: indexPath) as? PopularAndUpcomingMovieCell else {
            return UICollectionViewCell()
        }
        
        if let movie = viewModel.movieForIndexPath(indexPath) {
            cell.configure(with: movie)
        }
        
        return cell
    }
}

extension SeeAllMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        return cell
    }
}
