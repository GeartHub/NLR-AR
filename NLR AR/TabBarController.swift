//
//  TabBarController.swift
//  NLR AR
//
//  Created by Geart Otten on 03/05/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var aircraft: Aircraft?
    
    init(aircraft: Aircraft) {
        self.aircraft = aircraft
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let reportsViewController = PlaceholderViewController()

        let scanPlaneViewController = ViewController()
        scanPlaneViewController.aircraft = aircraft

        let helpViewController = PlaceholderViewController()

        let item1 = UITabBarItem(title: "Reports", image: UIImage(systemName: "folder.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Scan plane", image: UIImage(systemName: "camera.fill"), tag: 1)
        let item3 = UITabBarItem(title: "Help", image: UIImage(systemName: "questionmark.square.fill"), tag: 2)
        
        reportsViewController.tabBarItem = item1
        scanPlaneViewController.tabBarItem = item2
        helpViewController.tabBarItem = item3
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.viewControllers = [reportsViewController,scanPlaneViewController,helpViewController]

        self.selectedViewController = scanPlaneViewController
        self.selectedIndex = 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
