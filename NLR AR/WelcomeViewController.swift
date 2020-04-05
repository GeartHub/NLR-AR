//
//  WelcomeViewController.swift
//  NLR AR
//
//  Created by Ruurd Sinnema on 04/04/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeLabel = UILabel()
    
    let continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the background color
        self.view.backgroundColor = UIColor.white
        
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding and styling message
        self.welcomeLabel.textColor = UIColor.black
        self.welcomeLabel.text = "Welcome to the AR app of NLR"
        
        // Adding and styling button
        self.continueButton.setTitle("Continue", for: .normal)
        self.continueButton.setTitleColor(UIColor.systemBlue, for: .normal)
        self.continueButton.addTarget(self, action: #selector(goToMainView), for: .touchUpInside)
        self.continueButton.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 50,right: 0)
        
        
        // Adding items to the View
        view.addSubview(welcomeLabel)
        view.addSubview(continueButton)
        
        setupConstraints()
    }
    
    @objc func goToMainView() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    // Setup of the contraints for this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // welcomeLabelConstraints
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        //continueButtonConstraints
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Setting the status bar to dark
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
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
