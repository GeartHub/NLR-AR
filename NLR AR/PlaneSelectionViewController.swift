//
//  PlaneSelectionViewController.swift
//  NLR AR
//
//  Created by Ruurd Sinnema on 25/04/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class PlaneSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Jet fighters"
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "All jet fighters with stealth coating."
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataStack.instance.fetchedAircrafts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: planeCellId, for: indexPath)
        
        cell.textLabel!.text = CoreDataStack.instance.fetchedAircrafts[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToMainView(aircraft: CoreDataStack.instance.fetchedAircrafts[indexPath.row])
    }
    
    let planesTable = UITableView()
    
    let planeCellId = "PlaneCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataStack.instance.fetchAircrafts()
        // Setting the background color.
        self.view.backgroundColor = UIColor.black
        
        // Setting the title.
        self.title = "Aircrafts"
        // Prefers big title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Hiding the back button because we don't need to go back to welcome screen.
        self.navigationItem.setHidesBackButton(true, animated: true);
        
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
    
    @objc func goToMainView(aircraft: Aircraft) {
        let viewController = TabBarController(aircraft: aircraft)
        viewController.title = aircraft.name
        
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

class PlaneCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
