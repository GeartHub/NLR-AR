//
//  PlaceholderViewController.swift
//  NLR AR
//
//  Created by Geart Otten on 16/05/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class PlaceholderViewController: UITabBarController {

    var messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel.text = "Hier komt iets"
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        // Do any additional setup after loading the view.
        setupConstraints()
    }
    

    func setupConstraints() {
        NSLayoutConstraint.activate( [
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
