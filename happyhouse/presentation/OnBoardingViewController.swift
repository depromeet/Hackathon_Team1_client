//
//  OnBoardingViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - UI elements
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private lazy var startButton = UIButton()
    private lazy var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(startButton)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OnBoardingGuideViewCell.self, forCellWithReuseIdentifier: "ONBOARDING_GUIDE_VIEW_CELL")
        collectionView.isPagingEnabled = true
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        
        startButton.layer.roundCorners(radius: 22.5)
        startButton.backgroundColor = UIColor(red: 255, green: 219, blue: 99)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor(red: 10, green: 10, blue: 10), for: .normal)
        startButton.titleLabel?.font = FontProvider.font(size: 15, weight: .bold)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        startButton.alpha = 0.0
        
        pageControl.numberOfPages = OnBoardingGuide.allCases.count
        pageControl.currentPageIndicatorTintColor = UIColor(red: 255, green: 219, blue: 99)
        pageControl.pageIndicatorTintColor = UIColor(red: 216, green: 216, blue: 216)
        
        collectionView.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
            } else {
                make.bottom.equalTo(view).inset(100)
            }
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            
            make.left.equalTo(view).inset(24)
            make.right.equalTo(view).inset(24)
            
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(26)
            } else {
                make.bottom.equalTo(view).inset(26)
            }
        }
        
        pageControl.snp.makeConstraints { make in
            
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(38)
            } else {
                make.bottom.equalTo(view).inset(38)
            }
            make.centerX.equalTo(view)
        }
    }
    
    @objc func start() {
        let viewController = LoginViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Helpers
    private func showButton() {
        UIView.animate(withDuration: CATransaction.animationDuration(), animations: {
            self.startButton.alpha = 1.0
        })
    }
    
    private func hideButton() {
        UIView.animate(withDuration: CATransaction.animationDuration(), animations: {
            self.startButton.alpha = 0.0
        })
    }
    
}

// MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnBoardingGuide.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ONBOARDING_GUIDE_VIEW_CELL", for: indexPath) as! OnBoardingGuideViewCell
        let guide =  OnBoardingGuide.allCases[indexPath.row]
        cell.bind(to: guide)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OnBoardingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewOffset = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.size.width
        
        if scrollViewWidth == 0 {
            return
        }
        
        let currentPage = Int(ceil(scrollViewOffset/scrollViewWidth))
        
        pageControl.currentPage = currentPage
        
        guard let lastIndex = OnBoardingGuide.allCases.firstIndex(of: .third) else { return }
        
        if currentPage == lastIndex {
            showButton()
        } else {
            hideButton()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    
    // Remove spacing between blocks
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
