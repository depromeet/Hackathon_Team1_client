//
//  FamilyViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit
import RxSwift
import ScrollableDatepicker

class FamilyViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var works: [HouseWork] = [HouseWork(name: "청소기 돌리기", assigneeId: 1, isDone: false),
                                      HouseWork(name: "냉장고 청소", assigneeId: 1, isDone: true),
                                      HouseWork(name: "거실 청소", assigneeId: 1, isDone: false),
                                      HouseWork(name: "밥하기", assigneeId: 1, isDone:  false)]
    
    // MARK: - UI elements
    private lazy var navigationBar = UINavigationBar(frame: CGRect.zero)
    private lazy var datepicker = ScrollableDatepicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(datepicker)
        
        let navigationItem = UINavigationItem(title: "Total list")
        let closeImage = UIImage(named: "combinedShape")
        let addFriendButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(addFriend))
        addFriendButtonItem.tintColor = UIColor(red: 56, green: 56, blue: 56)
        
        navigationItem.rightBarButtonItem = addFriendButtonItem
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = UIColor(red: 255, green: 219, blue: 99)
        navigationBar.isTranslucent = false
        navigationBar.delegate = self
        
        
        var dates = [Date]()
        for day in -15...15 {
            dates.append(Date(timeIntervalSinceNow: Double(day * 86400)))
        }
        
        datepicker.dates = dates
        datepicker.selectedDate = Date()
        datepicker.delegate = self
        
        var configuration = Configuration()
        
        // selected date customization
        configuration.defaultDayStyle.dateTextColor = UIColor(red: 0, green: 0, blue: 0, opacity: 0.3)
        
        configuration.weekendDayStyle.weekDayTextFont = .systemFont(ofSize: 8, weight: UIFont.Weight.thin)
        configuration.weekendDayStyle.dateTextFont = .systemFont(ofSize: 20, weight: UIFont.Weight.thin)
        configuration.selectedDayStyle.backgroundColor = UIColor(white: 0.9, alpha: 1)
        configuration.selectedDayStyle.dateTextColor = UIColor(red: 0, green: 0, blue: 0)
        configuration.selectedDayStyle.selectorColor = UIColor(red: 255, green: 219, blue: 99)
        configuration.selectedDayStyle.backgroundColor = .clear
        configuration.daySizeCalculation = .numberOfVisibleItems(5)
        
        datepicker.configuration = configuration
        
        
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
        
        datepicker.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.top.equalTo(navigationBar.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func addFriend() {
        
    }
}

extension FamilyViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension FamilyViewController: ScrollableDatepickerDelegate {
    
    func datepicker(_ datepicker: ScrollableDatepicker, didSelectDate date: Date) {
        // showSelectedDate()
    }
    
}
