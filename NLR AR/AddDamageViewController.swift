//
//  AddDamageViewController.swift
//  NLR AR
//
//  Created by Ruurd Sinnema on 16/06/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class AddDamageViewController: UIViewController {
    
    let descriptionField = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: UIScreen.main.bounds.size.width, height: 50.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the background color
        self.view.backgroundColor = UIColor.black

        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.descriptionField.translatesAutoresizingMaskIntoConstraints = false
        
        // Descriptionfield
        descriptionField.backgroundColor = .yellow

        // Adding items to the View
        view.addSubview(descriptionField)
        
        setupConstraints()
    }
    
    @objc func goToMainView() {
        self.navigationController?.pushViewController(PlaneSelectionViewController(), animated: true)
        
    }
    
    // Setup of the contraints for this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // logoConstraints
        NSLayoutConstraint.activate([
            descriptionField.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionField.rightAnchor.constraint(equalTo: view.rightAnchor),
            descriptionField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
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
