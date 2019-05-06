//
//  OnBoardingGuideViewCell.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class OnBoardingGuideViewCell: UICollectionViewCell {
    
    private lazy var optionalImageView = UIImageView()
    private lazy var contentImageView = UIImageView()
    private lazy var descriptionLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 255, green: 219, blue: 99)
        
        contentView.addSubview(optionalImageView)
        contentView.addSubview(contentImageView)
        contentView.addSubview(descriptionLabel)
        
        
        descriptionLabel.font = FontProvider.font(size: 14, weight: .ultraLight)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        optionalImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentImageView.snp.top).offset(-11)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentImageView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
        }
        
        contentImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        // Force the view to update here to request the imageView's width when binding to guide
        contentView.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to guide: OnBoardingGuide) {
        let imageViewWidth = contentImageView.frame.width
        guard let imageWidth = guide.contentImage?.size.width else { return }
        
        // ImageView's width varies from device to device
        if imageViewWidth > imageWidth {
            contentImageView.contentMode = .scaleAspectFill
        } else {
            contentImageView.contentMode = .scaleAspectFit
            contentImageView.clipsToBounds = true
        }
        contentView.layoutIfNeeded()
        
        optionalImageView.image = guide.optionalImage
        descriptionLabel.text = guide.descriptionText
        contentImageView.image = guide.contentImage
    }
    
}

