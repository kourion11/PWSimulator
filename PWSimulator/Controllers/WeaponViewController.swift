//
//  WeaponViewController.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 17.07.2022.
//

import UIKit

class WeaponViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    var weaponsList = WeaponsList()
    var enchantModel = EnchantModel()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension WeaponViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weaponsList.weapons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = weaponsList.weapons[indexPath.row].name
        let image = weaponsList.weapons[indexPath.row].image
        cell.imageView?.image = image
        cell.textLabel?.text = model
        cell.textLabel?.textColor = .systemGreen
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        weaponsList.selectedWeapon(selectRow: indexPath.row)
        let vc = ViewController()
        vc.reloadViews()
        dismiss(animated: true)
    }
}
