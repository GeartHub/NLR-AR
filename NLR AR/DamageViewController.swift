//
//  DamageViewController.swift
//  NLR AR
//
//  Created by Ruurd Sinnema on 01/07/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class DamageViewController: UIViewController {
    let descriptionContentView = UIView()
    let descriptionLabel = UILabel()
    let descriptionField = UITextField()
    
    let titleContentView = UIView()
    let titleLabel = UILabel()
    let titleField  = UITextField()
    
    let dateContentView = UIView()
    let dateLabel = UILabel()
    let dateField  = UITextField()
    
    let damageSwitcherContentView = UIView()
    let damageSwitcherLabel = UILabel()
    let damageSwitcher = UISwitch()
    let damageSwitcherDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the background color
        self.view.backgroundColor = UIColor.black
        
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.descriptionContentView.translatesAutoresizingMaskIntoConstraints = false
        self.titleContentView.translatesAutoresizingMaskIntoConstraints = false
        self.dateContentView.translatesAutoresizingMaskIntoConstraints = false
        self.damageSwitcherContentView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionField.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleField.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateField.translatesAutoresizingMaskIntoConstraints = false
        self.damageSwitcherLabel.translatesAutoresizingMaskIntoConstraints = false
        self.damageSwitcher.translatesAutoresizingMaskIntoConstraints = false
        self.damageSwitcherDescription.translatesAutoresizingMaskIntoConstraints = false
        
        // Navigation
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteDamage))
        deleteButton.tintColor = UIColor.red
        self.navigationItem.rightBarButtonItem = deleteButton
        
        // Description View
        self.descriptionContentView.backgroundColor = .systemGray6
        
        // Title View
        self.titleContentView.backgroundColor = .systemGray6
        
        // Date View
        self.dateContentView.backgroundColor = .systemGray6
        
        // Damage switcher View
        self.damageSwitcherContentView.backgroundColor = .systemGray6
        
        // damageswitcher Label
        self.damageSwitcherLabel.text = "Big damage: Save for future analysis"
        self.damageSwitcherLabel.textColor = .white
        
        // damageswitcher description label
        self.damageSwitcherDescription.text = "Big damages will always be repaired straight away, so they don’t have to be saved for periodic maintenance. Check this box to save the damage for future analysis."
        self.damageSwitcherDescription.textColor = .systemGray
        self.damageSwitcherDescription.lineBreakMode = .byWordWrapping
        self.damageSwitcherDescription.sizeToFit()
        self.damageSwitcherDescription.numberOfLines = 10
        
        // Datefield
        self.dateField.placeholder = "01-06-2020"
        self.dateField.textAlignment = .right
        self.dateField.isUserInteractionEnabled = false
        
        // Date Label
        self.dateLabel.text = "Date added:"
        self.dateLabel.textColor = .white
        
        // Titlefield
        self.titleField.placeholder = "Issue #4"
        self.titleField.textAlignment = .right
        self.titleField.isUserInteractionEnabled = false
        
        // Title Label
        self.titleLabel.text = "Title:"
        self.titleLabel.textColor = .white
        
        // Descriptionfield
        self.descriptionField.placeholder = "Add a Description..."
        self.descriptionField.textAlignment = .right
        self.descriptionField.isUserInteractionEnabled = true
        
        // Description label
        self.descriptionLabel.text = "Description:"
        self.descriptionLabel.textColor = .white
        
        // Adding items to the View
        view.addSubview(descriptionContentView)
        descriptionContentView.addSubview(descriptionField)
        descriptionContentView.addSubview(descriptionLabel)
        
        view.addSubview(titleContentView)
        titleContentView.addSubview(titleField)
        titleContentView.addSubview(titleLabel)
        
        view.addSubview(dateContentView)
        dateContentView.addSubview(dateField)
        dateContentView.addSubview(dateLabel)
        
        view.addSubview(damageSwitcherContentView)
        damageSwitcherContentView.addSubview(damageSwitcher)
        damageSwitcherContentView.addSubview(damageSwitcherLabel)
        
        view.addSubview(damageSwitcherDescription)
        
        setupConstraints()
    }
    
    // Setup of the contraints for this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // Description constraints
        NSLayoutConstraint.activate([
            descriptionContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            descriptionContentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: descriptionContentView.leftAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 150),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContentView.topAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            descriptionField.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
            descriptionField.rightAnchor.constraint(equalTo: descriptionContentView.rightAnchor, constant: -20),
            descriptionField.topAnchor.constraint(equalTo: descriptionContentView.topAnchor, constant: 10),
            descriptionField.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor, constant: -10)
        ])
        // Title constraints
        NSLayoutConstraint.activate([
            titleContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleContentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 115)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: titleContentView.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.topAnchor.constraint(equalTo: titleContentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: titleContentView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            titleField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor),
            titleField.rightAnchor.constraint(equalTo: titleContentView.rightAnchor, constant: -20),
            titleField.topAnchor.constraint(equalTo: titleContentView.topAnchor, constant: 10),
            titleField.bottomAnchor.constraint(equalTo: titleContentView.bottomAnchor, constant: -10)
        ])
        // Date constraints
        NSLayoutConstraint.activate([
            dateContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dateContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            dateContentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 155)
        ])
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: dateContentView.leftAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            dateLabel.topAnchor.constraint(equalTo: dateContentView.topAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: dateContentView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            dateField.leftAnchor.constraint(equalTo: dateLabel.rightAnchor),
            dateField.rightAnchor.constraint(equalTo: dateContentView.rightAnchor, constant: -20),
            dateField.topAnchor.constraint(equalTo: dateContentView.topAnchor, constant: 10),
            dateField.bottomAnchor.constraint(equalTo: dateContentView.bottomAnchor, constant: -10)
        ])
        // DamageSwitcher constraints
        NSLayoutConstraint.activate([
            damageSwitcherContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            damageSwitcherContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            damageSwitcherContentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 230)
        ])
        NSLayoutConstraint.activate([
            damageSwitcherLabel.leftAnchor.constraint(equalTo: damageSwitcherContentView.leftAnchor, constant: 20),
            damageSwitcherLabel.widthAnchor.constraint(equalToConstant: 300),
            damageSwitcherLabel.topAnchor.constraint(equalTo: damageSwitcherContentView.topAnchor, constant: 10),
            damageSwitcherLabel.bottomAnchor.constraint(equalTo: damageSwitcherContentView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            damageSwitcher.rightAnchor.constraint(equalTo: damageSwitcherContentView.rightAnchor, constant: -20),
            damageSwitcher.topAnchor.constraint(equalTo: damageSwitcherContentView.topAnchor, constant: 10),
            damageSwitcher.bottomAnchor.constraint(equalTo: damageSwitcherContentView.bottomAnchor, constant: -10)
        ])
        // DamageSwitcher description constraints
        NSLayoutConstraint.activate([
            damageSwitcherDescription.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 290),
            damageSwitcherDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            damageSwitcherDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
    }
    
    @objc
    func deleteDamage() {
        // Code to save the damage
    }
    
    // Setting the status bar to dark
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
}
