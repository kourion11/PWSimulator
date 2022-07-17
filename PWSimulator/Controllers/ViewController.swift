//
//  ViewController.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 13.07.2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var weaponButton: UIButton = {
        let button = UIButton()
        button.setImage(enchantModel.image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(weaponPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var improveLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.text = "Улучшить снаряжение"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var currentAttackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.text = "Атака \(enchantModel.initialAttack) "
        return label
    }()
    
    lazy var plusAttackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemGreen
        label.text = "(+\(enchantModel.plusAttack))"
        return label
    }()
    
    private lazy var addResultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemYellow
        label.text = "Результат: "
        return label
    }()
    
    private lazy var itemsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemYellow
        label.text = "Особые предметы для улучшения:  "
        return label
    }()
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemYellow
        label.text = "История: "
        return label
    }()
    
    private lazy var improveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.titleColor(for: .normal)
        button.setTitleColor(
            #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
            for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitle("Улучшение", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.addTarget(self, action: #selector(enchantPressed), for: .touchUpInside)
        return button
    }()
    
    var enchantModel = EnchantModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTable()
        setupCounstraints()
    }
    
    @objc
    func weaponPressed() {
        let vc = WeaponViewController()
        present(vc, animated: true)
    }
    
    @objc
    func enchantPressed() {
        improveButton.alpha = 0.5
        improveButton.isEnabled = false
        enchantModel.pressButtonVibration()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.improveButton.alpha = 1.0
            self.improveButton.isEnabled = true
            self.enchanting()
        }
    }
    
    func enchanting() {
        enchantModel.result()
        currentAttackLabel.text = "Атака \(enchantModel.attackStat) "
        improveButton.isHidden = enchantModel.buttonIsNotActive
        reloadTable()
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupTable() {
        tableView.register(ResultCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        view.addSubview(weaponButton)
        view.addSubview(tableView)
        view.addSubview(improveLabel)
        view.addSubview(improveButton)
        view.addSubview(historyLabel)
        view.addSubview(itemsLabel)
        view.addSubview(addResultLabel)
        view.addSubview(currentAttackLabel)
        view.addSubview(plusAttackLabel)
    }
    
    func setupCounstraints() {
        weaponButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weaponButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            weaponButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weaponButton.heightAnchor.constraint(equalToConstant: 50),
            weaponButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: historyLabel.leftAnchor, constant: -5),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 5),
            tableView.heightAnchor.constraint(equalToConstant: 350),
            tableView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        improveLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            improveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            improveLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        addResultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addResultLabel.bottomAnchor.constraint(equalTo: itemsLabel.topAnchor, constant: -5),
            addResultLabel.leftAnchor.constraint(equalTo: itemsLabel.leftAnchor)
        ])
        
        currentAttackLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentAttackLabel.bottomAnchor.constraint(equalTo: itemsLabel.topAnchor, constant: -5),
            currentAttackLabel.leftAnchor.constraint(equalTo: addResultLabel.rightAnchor)
        ])
        
        plusAttackLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusAttackLabel.bottomAnchor.constraint(equalTo: itemsLabel.topAnchor, constant: -5),
            plusAttackLabel.leftAnchor.constraint(equalTo: currentAttackLabel.rightAnchor)
        ])
        
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemsLabel.bottomAnchor.constraint(equalTo: historyLabel.topAnchor, constant: -5),
            itemsLabel.leftAnchor.constraint(equalTo: historyLabel.leftAnchor)
        ])
        
        improveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            improveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            improveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            improveButton.heightAnchor.constraint(equalToConstant: 50),
            improveButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 240),
            historyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }
}
