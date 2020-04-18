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
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the background color
        self.view.backgroundColor = UIColor.black
        
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Logo of NLR
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        
        // Adding and styling message
        self.welcomeLabel.textColor = UIColor.white
        self.welcomeLabel.text = "Welcome to the AR app of NLR"
        
        // Adding and styling button
        self.continueButton.setTitle("Continue", for: .normal)
        self.continueButton.setTitleColor(UIColor.white, for: .normal)
        self.continueButton.backgroundColor = UIColor.systemBlue
        self.continueButton.addTarget(self, action: #selector(goToMainView), for: .touchUpInside)
        self.continueButton.contentEdgeInsets = UIEdgeInsets(top: 20,left: 40,bottom: 20,right: 40)
        
        
        
        // navigation controller buttons
        // Adding items to the View
        view.addSubview(imageView)
        view.addSubview(welcomeLabel)
        view.addSubview(continueButton)
        
        setupConstraints()
    }
    
    @objc func goToMainView() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    // Setup of the contraints for this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // logoConstraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 197),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: -20),
            
        ])
        // welcomeLabelConstraints
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            welcomeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        //continueButtonConstraints
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
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
