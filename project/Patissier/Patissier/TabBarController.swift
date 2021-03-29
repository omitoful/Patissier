//
//  TabBarController.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/27.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.barTintColor = .blue
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let _ = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        setTabBar()
       
    }
    func setTabBar() {
        
        let storeController = UINavigationController(rootViewController: CollectionViewController())
        storeController.tabBarItem.title = "store"
        storeController.tabBarItem.image = UIImage(named: "icon-store")
        storeController.tabBarItem.selectedImage = UIImage(named: "icon-store")
        
        let profileController = UINavigationController(rootViewController: SegmentViewController())
        profileController.tabBarItem.title = "profile"
        profileController.tabBarItem.image = UIImage(named: "icon-profile")
        profileController.tabBarItem.selectedImage = UIImage(named: "icon-profile-selected")
        
        viewControllers = [storeController, profileController]
        
    }

}
