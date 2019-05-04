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
    private lazy var checkbox = UIButton()
    
    var button: UIButton {
        return checkbox
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionColor = UIColor(red: 255, green: 219, blue: 99, opacity: 0.3)
        contentView.addSubview(label)
        contentView.addSubview(checkbox)
        
        label.font = FontProvider.font(size: 16, weight: .light)
        
        checkbox.setImage(UIImage(named: "checkboxDefault"), for: .normal)
        checkbox.setImage(UIImage(named: "checkboxSelect"), for: .highlighted)
        checkbox.setImage(UIImage(named: "checkboxComplete"), for: .selected)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        checkbox.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.right).inset(38)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to work: HouseWork) {
        label.text = work.name
        
        if work.isDone {
            label.textColor = UIColor(red: 0, green: 0, blue: 0, opacity: 0.3)
//            checkbox.setImage(UIImage(named: "checkboxComplete"), for: .normal)
//            checkbox.setImage(UIImage(named: "checkboxComplete"), for: .selected)
            checkbox.isHighlighted = false
            checkbox.isSelected = true
            
        } else {
            label.textColor = UIColor(red: 0, green: 0, blue: 0)
            checkbox.isHighlighted = false
            checkbox.isSelected = false
        }
    }
}
