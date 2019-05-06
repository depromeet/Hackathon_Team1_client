//
//  FamilyMemberViewCell.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class FamilyMemeberViewCell: UICollectionViewCell {
    
    public static let identifier = "FAMILY_MEMBER_VIEW_CELL"
    
    private var user: User?
    
    // MARK: - UI elements
    private lazy var profileImageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(tableView)
        
        profileImageView.layer.roundCorners(radius: 40)
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = FontProvider.font(size: 16, weight: .semibold)
        
        tableView.register(FamilyMemberHouseWorkViewCell.self, forCellReuseIdentifier: FamilyMemberHouseWorkViewCell.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.top.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(profileImageView)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to user: User) {
        if let profileUrl = user.profileUrl {
            profileImageView.setImage(urlString: profileUrl, placeholder: UIImage(named: "invalidName"))
        }
        
        nameLabel.text = user.nickname
        self.user = user
        
        tableView.reloadData()
    }
    
}

extension FamilyMemeberViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.houseWorks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FamilyMemberHouseWorkViewCell.identifier) as! FamilyMemberHouseWorkViewCell
        
        guard let houseWork = user?.houseWorks?.item(at: indexPath.row) else { return cell }
        
        cell.bind(to: houseWork)
        return cell
    }
    
    
}

extension FamilyMemeberViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
