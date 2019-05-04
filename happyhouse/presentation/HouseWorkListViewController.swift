//
//  HouseWorkListViewCell.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import Foundation
import RxSwift
import ScrollableDatepicker

class HouseWorkListViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var works: [HouseWork] = [HouseWork(name: "청소기 돌리기", assigneeId: 1, isDone: false),
                                      HouseWork(name: "냉장고 청소", assigneeId: 1, isDone: true),
                                      HouseWork(name: "거실 청소", assigneeId: 1, isDone: false),
                                      HouseWork(name: "밥하기", assigneeId: 1, isDone:  false)]
    
    // MARK: - UI elements
    private lazy var navigationBar = UINavigationBar(frame: CGRect.zero)
    private lazy var profileImageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var datepicker = ScrollableDatepicker()
    private lazy var tableView = UITableView()
    private lazy var floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(datepicker)
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        
        
        let navigationItem = UINavigationItem(title: "Personal list")
        let closeImage = UIImage(named: "combinedShape")
        let addFriendButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(addFriend))
        addFriendButtonItem.tintColor = UIColor(red: 56, green: 56, blue: 56)
        
        navigationItem.rightBarButtonItem = addFriendButtonItem
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = UIColor(red: 255, green: 219, blue: 99)
        navigationBar.isTranslucent = false
        navigationBar.delegate = self
        
        profileImageView.setImage(urlString: SettingsProvider.shared.userProfileUrl, placeholder: UIImage(named: "invalidName"))
        profileImageView.layer.roundCorners(radius: 35)
        
        nameLabel.text = SettingsProvider.shared.userNickname
        nameLabel.font = FontProvider.font(size: 16, weight: .semibold)
        
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
        configuration.daySizeCalculation = .numberOfVisibleItems(3)
        
        datepicker.configuration = configuration
        
        tableView.register(HouseWorkViewCell.self, forCellReuseIdentifier: HouseWorkViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 53
        tableView.dataSource = self
        tableView.delegate = self
        
        floatingButton.setImage(UIImage(named: "btn"), for: .normal)
        
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
        
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(navigationBar.snp.bottom).offset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.top.equalTo(profileImageView.snp.centerY)
        }
        
        datepicker.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(65)
            
            make.top.equalTo(navigationBar.snp.bottom).offset(32)
            make.right.equalToSuperview().inset(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
            make.bottom.equalToSuperview().inset(28)
            make.right.equalToSuperview().inset(20)
        }
        
        bindToSubViews()
    }
    
    private func bindToSubViews() {
        floatingButton.rx.tap
            .bind {
                let alertController = UIAlertController(title: "할 일을 등록해주세요 😎", message: "", preferredStyle: .alert)
                alertController.addTextField { textField in
                    textField.placeholder = "청소기 돌리기"
                }
                let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak alertController] _ in
                    guard
                        let alertController = alertController,
                        let textField = alertController.textFields?.first,
                        let name = textField.text else { return }
                    
                    // Add housework here
                    BackendService.createTask(taskName: name, assigneeId: SettingsProvider.shared.userUid)
                    .observeOn(MainScheduler.instance)
                        .subscribe(onSuccess: { work in
                            self.works.append(work)
                            self.tableView.reloadData()
                        }, onError: { error in
                            print(error)
                        })
                }
                alertController.addAction(confirmAction)
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    @objc func addFriend() {
        let viewController = FamilyViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HouseWorkListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseWorkViewCell.identifier) as! HouseWorkViewCell
        guard let work = works.item(at: indexPath.row) else { return cell }
        cell.bind(to: work)
        return cell
    }
}

extension HouseWorkListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard var work = works.item(at: indexPath.row) else { return }
        work.isDone = !work.isDone
        works[indexPath.row] = work
        
        // Button UI
        let cell = tableView.cellForRow(at: indexPath) as? HouseWorkViewCell
        if work.isDone {
            cell?.button.isHighlighted = true
        }
        
        CATransaction.begin()
        tableView.beginUpdates()
        CATransaction.setCompletionBlock {
            // Code to be executed upon completion
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
        CATransaction.commit()
    }
}

extension HouseWorkListViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension HouseWorkListViewController: ScrollableDatepickerDelegate {
    
    func datepicker(_ datepicker: ScrollableDatepicker, didSelectDate date: Date) {
        // showSelectedDate()
    }
    
}
