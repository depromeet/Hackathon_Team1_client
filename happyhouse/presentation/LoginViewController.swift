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
    private lazy var label = UILabel()
    private lazy var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(loginButton)
        
        label.text = "Perform login here.."
        loginButton.setTitle("Kakaotalk login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .yellow
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
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
                            
                            let viewController = MainViewController()
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }, onError: { error in
                            
                            let viewController = MainViewController()
                            self.navigationController?.pushViewController(viewController, animated: true)
                            print(error)
                        })
                })
        }.disposed(by: disposeBag)
    }
    
}
