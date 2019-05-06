//
//  FamilyMemberHouseWorkViewCell.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class FamilyMemberHouseWorkViewCell: UITableViewCell {
    
    public static let identifier = "FAMILY_MEMBER_HOUSE_WORK_VIEW_CELL"
    // MARK: - UI elements
    private lazy var nameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        
        nameLabel.font = FontProvider.font(size: 16, weight: .light)
        nameLabel.numberOfLines = 0
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to houseWork: HouseWork) {
        nameLabel.text = houseWork.name
        if houseWork.isDone {
            nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, opacity: 0.3)
        } else {
            nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0)
        }
    }
    
}


