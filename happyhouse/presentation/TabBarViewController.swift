//
//  TabBarViewController.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(red: 56, green: 56, blue: 56)

        
        let appearance = UITabBarItem.appearance()
        
        let houseworkListViewController = HouseWorkListViewController()
        
        let calendarOnImage = UIImage(named: "personalList_on")
        let calendarOffImage = UIImage(named: "personalList_off")
        houseworkListViewController.tabBarItem = UITabBarItem(title: " ",
                                                                image: calendarOffImage,
                                                                selectedImage: calendarOnImage)
        houseworkListViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let familyViewController = FamilyViewController()
        
        let exploreOnImage = UIImage(named: "totalList_on")
        let exploreOffImage = UIImage(named: "totalList_off")
        familyViewController.tabBarItem = UITabBarItem(title: " ",
                                                               image: exploreOffImage,
                                                               selectedImage: exploreOnImage)
        familyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let statisticsViewControllre = UIViewController()
        
        let categoryOnImage = UIImage(named: "monthlyGraph_on")
        let categoryOffImage = UIImage(named: "monthlyGraph_off")
        statisticsViewControllre.tabBarItem = UITabBarItem(title: " ",
                                                                image: categoryOffImage,
                                                                selectedImage: categoryOnImage)
        statisticsViewControllre.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let shareViewController = ShareViewController()
        
        let profileOnImage = UIImage(named: "add_on")
        let profileOffImage = UIImage(named: "add_off")
        shareViewController.tabBarItem = UITabBarItem(title: " ",
                                                               image: profileOffImage,
                                                               selectedImage: profileOnImage)
        shareViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let tabBarList = [houseworkListViewController,
                          familyViewController,
                          statisticsViewControllre,
                          shareViewController]
        
        viewControllers = tabBarList
    }
}
