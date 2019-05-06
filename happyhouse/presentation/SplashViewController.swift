//
//  SplashViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    // MARK: - UI elements
    private lazy var iconImageView = UIImageView()
    private lazy var labelImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255, green: 219, blue: 99)
        view.addSubview(iconImageView)
        view.addSubview(labelImageView)
        
        iconImageView.image = UIImage(named: "group9")
        labelImageView.image = UIImage(named: "group23")
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        labelImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(13)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            if SettingsProvider.shared.isUserLoggedIn {
                let viewController = TabBarController()
                self.navigationController?.pushViewController(viewController, animated: false)
            } else {
                
                let viewController = OnBoardingViewController()
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }
}
