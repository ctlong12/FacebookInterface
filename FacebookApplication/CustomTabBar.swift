//
//  CustomTabBar.swift
//  PBXApplication
//
//  Created by Chandler on 4/30/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news")
        
        let directMessagesController = MessagesController()
        let secondNavagationController = UINavigationController(rootViewController: directMessagesController)
        secondNavagationController.title = "Messages"
        secondNavagationController.tabBarItem.image = UIImage(named: "messages")
        
        let profileViewController = UIViewController()
        let thirdNavagationController = UINavigationController(rootViewController: profileViewController)
        thirdNavagationController.title = "Profile & Settings"
        thirdNavagationController.tabBarItem.image = UIImage(named: "profile")
        
        viewControllers = [navigationController, secondNavagationController, thirdNavagationController]
        
    }
}
