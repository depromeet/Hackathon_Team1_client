//
//  MainViewControlller.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import Foundation
import RxSwift

class MainViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var works: [HouseWork] = [HouseWork(name: "청소기 돌리기"),
                                      HouseWork(name: "냉장고 청소"),
                                      HouseWork(name: "거실 청소"),
                                      HouseWork(name: "밥하기")]
    
    // MARK: - UI elements
    private lazy var label = UILabel()
    private lazy var tableView = UITableView()
    private lazy var floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        
        label.text = "Happy House!"
        
        tableView.register(HouseWorkViewCell.self, forCellReuseIdentifier: HouseWorkViewCell.identifier)
        tableView.rowHeight = 53
        tableView.dataSource = self
        tableView.delegate = self
        
        floatingButton.setImage(UIImage(named: "btn"), for: .normal)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(165)
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
                    self.works.append(HouseWork(name: name))
                    self.tableView.reloadData()
                }
                alertController.addAction(confirmAction)
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
}

extension MainViewController: UITableViewDataSource {
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
