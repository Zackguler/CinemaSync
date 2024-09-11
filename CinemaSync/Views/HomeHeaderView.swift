//
//  HomeHeaderView.swift
//  CinemaSync
//
//  Created by Semih Güler on 1.08.2024.
//

import UIKit

class HomeHeaderView: UIView {
    
    //    MARK: - UI Elements
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "CinemaSync"
        return label
    }()
    
    private lazy var searchIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "black-search-icon"))
        return image
    }()
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Private methods
    private func setupViews() {
        addSubview(headerLabel)
        addSubview(searchIcon)
        baseBoldLabelStyle(headerLabel, withFontSize: 36)
        layout()
    }
}

    //    MARK: - Layout

extension HomeHeaderView {
    private func layout() {
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        searchIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
