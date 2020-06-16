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
    let descriptionField = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: UIScreen.main.bounds.size.width, height: 50.0))
    
    let titleLabel = UILabel()
    let titleField  = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the background color
        self.view.backgroundColor = UIColor.black

        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.descriptionField.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleField.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionField.translatesAutoresizingMaskIntoConstraints = false
        
        // Description View
        
        
        // Descriptionfield
        self.descriptionField.backgroundColor = .systemGray6
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
            descriptionField.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)

        ])
         NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 150)
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
