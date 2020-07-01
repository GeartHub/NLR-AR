//
//  ReportSelectionViewController.swift
//  NLR AR
//
//  Created by Ruurd Sinnema on 16/05/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class ReportSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArray[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.gray
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionFooterArray[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let footer = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor.gray
        footer.textLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aircraft?.damageNodeArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: planeCellId, for: indexPath)
        
        cell.textLabel!.text = aircraft?.damageNodeArray[indexPath.row].title
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.systemGray6
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToMainView()
    }

    let planesTable = UITableView()
    
    let planeCellId = "PlaneCellId"
    
    let sectionTitleArray = [0 : "Small damages for maintenance - f-35-001", 1 : "Big damages for future analysis - F-35-001"]
    
    let sectionFooterArray = [0 : "These small damages must all be repaired in the next periodic maintenance.", 1 : "These damages will be saved for further analysis."]
    
    var aircraft : Aircraft?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Setting the background color.
        self.view.backgroundColor = UIColor.black
        
        // Setting the title.
        self.title = "Reports"
        
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.planesTable.translatesAutoresizingMaskIntoConstraints = false
        
        // Add list to view
        view.addSubview(planesTable)
        
        // Register the list
        planesTable.register(PlaneCell.self, forCellReuseIdentifier: planeCellId)
        self.planesTable.tableFooterView = UIView()
        
        // Setup delegates
        planesTable.delegate = self
        planesTable.dataSource = self
        
        setupConstraints()
    }
    
    @objc func goToMainView() {
        let viewController = PlaceholderViewController()
        viewController.title = title
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    // Setup of the contraints for this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // Constraints
        NSLayoutConstraint.activate([
            planesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            planesTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            planesTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            planesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
}
