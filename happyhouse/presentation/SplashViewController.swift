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
    private lazy var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        
        label.text = "Happy House!"
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            if SettingsProvider.shared.isUserLoggedIn {
                let viewController = HouseWorkListViewController()
                self.navigationController?.pushViewController(viewController, animated: false)
            } else {
                let viewController = LoginViewController()
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }
}
