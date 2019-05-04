//
//  ShareViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit
import RxSwift
import Toaster

class ShareViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    // MARK: - UI elements
    private lazy var navigationBar = UINavigationBar(frame: CGRect.zero)
    private lazy var codeLabel = UILabel()
    private lazy var codeTextField = UITextField()
    private lazy var divider = UIView()
    private lazy var myCodeLabel = UILabel()
    private lazy var myCode = UILabel()
    private lazy var copyButton = UIButton()
    private lazy var submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(codeLabel)
        view.addSubview(codeTextField)
        view.addSubview(divider)
        view.addSubview(myCodeLabel)
        view.addSubview(myCode)
        view.addSubview(copyButton)
        view.addSubview(submitButton)
        
        let navigationItem = UINavigationItem(title: "Add family member")
        let closeImage = UIImage(named: "combinedShape")
        let addFriendButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(addFriend))
        addFriendButtonItem.tintColor = UIColor(red: 56, green: 56, blue: 56)
        
        navigationItem.rightBarButtonItem = addFriendButtonItem
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = UIColor(red: 255, green: 219, blue: 99)
        navigationBar.isTranslucent = false
        navigationBar.delegate = self
        
        codeLabel.font = FontProvider.font(size: 16, weight: .light)
        codeLabel.text = "초대 코드 번호"
        
        codeTextField.placeholder = "친구 코드 번호"
        codeTextField.font = FontProvider.font(size: 20, weight: .bold)
        codeTextField.returnKeyType = .done
        codeTextField.delegate = self
        
        divider.backgroundColor = .black
        
        myCodeLabel.font = FontProvider.font(size: 16, weight: .light)
        myCodeLabel.text = "내 코드 번호"
        
        myCode.font = FontProvider.font(size: 20, weight: .bold)
        myCode.textColor = UIColor(red: 36, green: 36, blue: 36)
        myCode.text = String(SettingsProvider.shared.userUid)
        
        copyButton.setImage(UIImage(named: "iconCopy"), for: .normal)
        
        submitButton.setImage(UIImage(named: "btn_submit"), for: .normal)
        
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
        
        codeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(navigationBar.snp.bottom).offset(50)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(codeLabel.snp.bottom).offset(1)
        }
        
        divider.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(1)
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(codeTextField.snp.bottom).offset(6)
        }
        
        myCodeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(divider.snp.bottom).offset(50)
        }
        
        myCode.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(myCodeLabel.snp.bottom).offset(1)
        }
        
        copyButton.snp.makeConstraints { make in
            make.left.equalTo(myCode.snp.right).offset(8)
            make.centerY.equalTo(myCode)
        }
        
        submitButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(81)
        }
        
        bindToSubViews()
        
    }
    
    private func bindToSubViews() {
        submitButton.rx.tap
            .bind {
                guard let query = self.codeTextField.text else {
                    return
                }
                if query.isEmpty {
                    Toast(text: "초대 코드를 입력해주세요 😎").show()
                    return
                }
                
                guard let integerQuery = Int(query) else {
                    Toast(text: "유효한 초대 코드를 입력해주세요 😎").show()
                    return
                }
                
                BackendService.createFamily(myId: SettingsProvider.shared.userUid, friendId: integerQuery)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onSuccess: { family in
                        Toast(text: "새로운 가족이 생겼습니다 😎").show()
                    }, onError: { error in
                        print(error)
                    })
                
        }.disposed(by: disposeBag)
    }
    
    @objc func addFriend() {
        
    }

}


extension ShareViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension ShareViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
