//
//  LoginViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    // MARK: - UI elements
    private lazy var loginImageView = UIImageView()
    private lazy var loginButtonImageView = UIImageView()
    private lazy var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255, green: 219, blue: 99)
        
        view.addSubview(loginImageView)
        view.addSubview(loginButton)
        view.addSubview(loginButtonImageView)
        
        loginImageView.image = UIImage(named: "imgH")
        
        loginButtonImageView.image = UIImage(named: "btnDown")
        
        loginButton.backgroundColor = UIColor(red: 255, green: 236, blue: 31)
        
        loginImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        loginButtonImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(loginButton).offset(10)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            
            make.bottom.equalTo(view)
            
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                let bottomPadding = window?.safeAreaInsets.bottom ?? 0
                make.height.equalTo(60 + bottomPadding)
            } else {
                make.height.equalTo(60)
            }

        }
        
        bindToSubViews()
    }
    
    private func bindToSubViews() {
        loginButton.rx.tap
            .bind {
                let session: KOSession = KOSession.shared();
                
                if session.isOpen() {
                    session.close()
                }
                
                session.open(completionHandler: { (error) -> Void in
                    
                    if !session.isOpen() {
                        if let error = error as NSError? {
                            switch error.code {
                            case Int(KOErrorCancelled.rawValue):
                                break
                            default:
                                print(error.localizedDescription)
                            }
                        }
                    }
                    print("Kakaotalk login complete")
                    print("Access token 🔑 : \(session.accessToken)")
                    
                    guard let token = session.accessToken else { return }
                    BackendService.signIn(kakaoToken: token)
                        .observeOn(MainScheduler.instance)
                        .debug()
                        .subscribe(onSuccess: { user in
                            SettingsProvider.shared.isUserLoggedIn = true
                            SettingsProvider.shared.userUid = user.userUid
                            if let profileUrl = user.profileUrl {
                                SettingsProvider.shared.userProfileUrl = profileUrl
                            }
                            SettingsProvider.shared.userNickname = user.nickname
                            
                            let viewController = TabBarController()
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }, onError: { error in
                            
                            SettingsProvider.shared.isUserLoggedIn = true
                            SettingsProvider.shared.userUid = 20190504
                            SettingsProvider.shared.userNickname = "김승주"
                            
                            let viewController = TabBarController()
                            self.navigationController?.pushViewController(viewController, animated: true)
                            print(error)
                        })
                })
        }.disposed(by: disposeBag)
    }
    
}
