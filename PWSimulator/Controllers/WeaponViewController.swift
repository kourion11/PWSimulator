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
    
    var enchantModel: EnchantModel!
    var weaponList = WeaponList()
    
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
        return weaponList.weapons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = weaponList.weapons[indexPath.row].name
        let image = weaponList.weapons[indexPath.row].image
        cell.imageView?.image = image
        cell.textLabel?.text = model
        cell.textLabel?.textColor = .systemGreen
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let presenter = presentingViewController as? ViewController {
            let model = weaponList.weapons[indexPath.row]
            presenter.enchantModel = EnchantModel(image: model.image,
                                                  weaponName: model.name,
                                                  attackStat: model.attackStat,
                                                  plusAttack: model.plusAttack)
            presenter.weaponButton.imageView?.image = presenter.enchantModel.image
            presenter.currentAttackLabel.text = "Атака \(presenter.enchantModel.initialAttack) "
            presenter.plusAttackLabel.text = "(+\(presenter.enchantModel.plusAttack))"
            presenter.weaponNameLabel.text = presenter.enchantModel.weaponName
            presenter.enchantModel.weaponHere = true
            presenter.improveButton.isEnabled = true
            presenter.improveButton.alpha = 1.0
        }
        dismiss(animated: true)
    }
}
