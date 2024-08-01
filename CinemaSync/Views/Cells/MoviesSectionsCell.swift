//
//  MoviesSectionsCell.swift
//  CinemaSync
//
//  Created by Semih Güler on 1.08.2024.
//

import UIKit

class MoviesSectionsCell: UITableViewCell {
    
    private var movies: [Movie] = []
    
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var seeAllLabel: UILabel = {
        let label = UILabel()
        label.text = "See all"
        return label
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movies: [Movie]) {
        self.movies = movies
        moviesCollectionView.reloadData()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeAllLabel)
        contentView.addSubview(moviesCollectionView)
        selectionStyle = .none
        baseBoldLabelStyle(titleLabel)
        baseBoldLabelStyle(seeAllLabel, withFontSize: 10, color: .systemBlue)
        layout()
    }
}

// MARK: - Layout

extension MoviesSectionsCell {
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        moviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(300)
        }
        seeAllLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(16)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MoviesSectionsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.item])
        return cell
    }
}
