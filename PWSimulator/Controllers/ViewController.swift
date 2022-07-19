//
//  ViewController.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 13.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "enchant_window")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    lazy var weaponButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noItem"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(weaponPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var weaponNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemYellow
        label.text  = " "
        return label
    }()
    
    lazy var stoneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noItem"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(stonePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var improveLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.text = "Улучшить снаряжение"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var currentAttackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.text = " "
        return label
    }()
    
    lazy var plusAttackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemGreen
        label.text = " "
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
        label.text = "Особые материалы для улучшения:  "
        return label
    }()
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemYellow
        label.text = "История: "
        return label
    }()
    
    lazy var stoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemYellow
        label.text = " "
        return label
    }()
    
    lazy var improveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.titleColor(for: .normal)
        button.setTitleColor(
            #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
            for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitle("Улучшение", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.addTarget(self, action: #selector(enchantPressed), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    var enchantModel: EnchantModel!
    var weaponList = WeaponList()
    var stoneList = StoneList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStats()
        setupViews()
        setupTable()
        setupCounstraints()
    }
    
    func getStats() {
        let model = weaponList.weapons[0]
        enchantModel = EnchantModel(
            image: model.image,
            weaponName: model.name,
            attackStat: model.attackStat,
            plusAttack: model.plusAttack)
    }
    
    @objc
    func weaponPressed() {
        let vc = WeaponViewController()
        present(vc, animated: true)
    }
    
    @objc
    func stonePressed() {
        let vc = StoneViewController()
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
        view.addSubview(backgroundImage)
        view.addSubview(weaponButton)
        view.addSubview(weaponNameLabel)
        view.addSubview(stoneButton)
        view.addSubview(tableView)
        view.addSubview(improveLabel)
        view.addSubview(improveButton)
        view.addSubview(historyLabel)
        view.addSubview(itemsLabel)
        view.addSubview(addResultLabel)
        view.addSubview(currentAttackLabel)
        view.addSubview(plusAttackLabel)
        view.addSubview(stoneLabel)
    }
    
    func setupCounstraints() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        improveLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            improveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            improveLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        weaponButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weaponButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            weaponButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weaponButton.heightAnchor.constraint(equalToConstant: 50),
            weaponButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        weaponNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weaponNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 182),
            weaponNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        addResultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addResultLabel.topAnchor.constraint(equalTo: weaponNameLabel.bottomAnchor, constant: 20),
            addResultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 34)
        ])
        
        currentAttackLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentAttackLabel.topAnchor.constraint(equalTo: addResultLabel.topAnchor),
            currentAttackLabel.leftAnchor.constraint(equalTo: addResultLabel.rightAnchor)
        ])
        
        plusAttackLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusAttackLabel.topAnchor.constraint(equalTo: addResultLabel.topAnchor),
            plusAttackLabel.leftAnchor.constraint(equalTo: currentAttackLabel.rightAnchor)
        ])
        
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemsLabel.topAnchor.constraint(equalTo: addResultLabel.bottomAnchor, constant: 100),
            itemsLabel.leftAnchor.constraint(equalTo: addResultLabel.leftAnchor)
        ])
        
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 415),
            historyLabel.leftAnchor.constraint(equalTo: addResultLabel.leftAnchor)
        ])
        
        stoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stoneButton.bottomAnchor.constraint(equalTo: historyLabel.bottomAnchor),
            stoneButton.leftAnchor.constraint(equalTo: historyLabel.rightAnchor, constant: 10),
            stoneButton.heightAnchor.constraint(equalToConstant: 50),
            stoneButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        stoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stoneLabel.bottomAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: -15),
            stoneLabel.leftAnchor.constraint(equalTo: stoneButton.rightAnchor, constant: 15)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 25),
            tableView.heightAnchor.constraint(equalToConstant: 230),
            tableView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        improveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            improveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
            improveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            improveButton.heightAnchor.constraint(equalToConstant: 40),
            improveButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}
