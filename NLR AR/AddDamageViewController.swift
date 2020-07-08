//
//  AddDamageViewController.swift
//  NLR AR
//
//  Created by Ruurd Sinnema on 16/06/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class AddDamageViewController: UIViewController {
    
    let descriptionContentView = UIView()
    let descriptionLabel = UILabel()
    let descriptionField = UITextField()
    
    let titleLabel = UILabel()
    let titleField  = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the background color
        self.view.backgroundColor = UIColor.black

        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.descriptionContentView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionField.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleField.translatesAutoresizingMaskIntoConstraints = false

        self.title = "Add Damage"
        // Description View
         self.descriptionContentView.backgroundColor = .systemGray6
        
        // Descriptionfield
       
        self.descriptionField.placeholder = "Add a Description..."
        self.descriptionField.isUserInteractionEnabled = true
        
        // Description label
        self.descriptionLabel.text = "Description:"
        self.descriptionLabel.textColor = .white

        // Adding items to the View
        view.addSubview(descriptionContentView)
        descriptionContentView.addSubview(descriptionField)
        descriptionContentView.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    // Setup of the contraints for this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // logoConstraints
        NSLayoutConstraint.activate([
            descriptionContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            descriptionContentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
         NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: descriptionContentView.leftAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 150),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContentView.topAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor, constant: -10)
         ])
        NSLayoutConstraint.activate([
           descriptionField.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
           descriptionField.rightAnchor.constraint(equalTo: descriptionContentView.rightAnchor),
           descriptionField.topAnchor.constraint(equalTo: descriptionContentView.topAnchor, constant: 10),
           descriptionField.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor, constant: -10)
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
