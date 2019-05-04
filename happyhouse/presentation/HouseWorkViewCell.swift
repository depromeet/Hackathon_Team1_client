//
//  HouseWorkViewCell.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class HouseWorkViewCell: UITableViewCell {
    
    public static let identifier = "HOUSE_WORK_VIEW_CELL"
    
    // MARK: UI elements
    private lazy var label = UILabel()
    private lazy var checkbox = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        label.font = FontProvider.font(size: 16, weight: .light)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to work: HouseWork) {
        label.text = work.name
    }
}
