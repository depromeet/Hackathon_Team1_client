//
//  StatisticsViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    // MARK: - UI elements
    private lazy var navigationBar = UINavigationBar(frame: CGRect.zero)
    private lazy var graphImageView = UIImageView()
    private lazy var overlayView = UIView()
    private lazy var constructionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(graphImageView)
        view.addSubview(overlayView)
        view.addSubview(constructionLabel)
        
        let navigationItem = UINavigationItem(title: "Monthly graph")
//        let closeImage = UIImage(named: "combinedShape")
//        let addFriendButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(addFriend))
//        addFriendButtonItem.tintColor = UIColor(red: 56, green: 56, blue: 56)
        
//        navigationItem.rightBarButtonItem = addFriendButtonItem
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = UIColor(red: 255, green: 219, blue: 99)
        navigationBar.isTranslucent = false
        navigationBar.delegate = self
        
        graphImageView.image = UIImage(named: "graphImage")
        
        overlayView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, opacity: 0.7)
        
        constructionLabel.text = "아직 공사중이에요! 🔨"
        
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(44)
            
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        graphImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        constructionLabel.snp.makeConstraints { make in
            make.center.equalTo(overlayView)
        }
    }
}


extension StatisticsViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
