//
//  ViewController.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 13.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var weaponImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "weapon")
        return imageView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "black_background")
        return imageView
    }()
    
    private lazy var improveLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.text = "Улучшить снаряжение"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var currentAttackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.text = "Атака 1632 "
        return label
    }()
    
    private lazy var plusAttackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemGreen
        label.text = "( )"
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
        button.setTitle("Улучшить", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(improve), for: .touchUpInside)
        return button
    }()
    
    var enchant = 0
    var attackStat = 1632

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCounstraints()
    }
    
    @objc
    func improve() {
        let improveChance = Int.random(in: 0...100)
        if enchant < 12 {
            if improveChance >= 50 {
                enchant += 1
                attackStat += 133
                plusAttackLabel.text = "(+133)"
                currentAttackLabel.text = "Атака \(attackStat) "
                resultLabel.text = "Усовершенствование прошло успешно."
                resultLabel.textColor = .systemGreen
            } else {
                if enchant > 0 && attackStat >= 1632 {
                    enchant -= 1
                    attackStat -= 133
                    currentAttackLabel.text = "Атака \(attackStat) "
                } else {
                    enchant = 0
                    attackStat = 1632
                    currentAttackLabel.text = "Атака \(attackStat) "
                    plusAttackLabel.text = "( )"
                }
                resultLabel.text = "Не удалось усовершенствовать. \rУровень совершенства упал до \(enchant)."
                resultLabel.textColor = .systemYellow
            }
        } else {
            improveButton.isHidden = true
        }
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        view.addSubview(weaponImage)
        view.addSubview(backgroundImage)
        view.addSubview(improveLabel)
        view.addSubview(improveButton)
        view.addSubview(resultLabel)
        view.addSubview(historyLabel)
        view.addSubview(itemsLabel)
        view.addSubview(addResultLabel)
        view.addSubview(currentAttackLabel)
        view.addSubview(plusAttackLabel)
    }
    
    func setupCounstraints() {
        weaponImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weaponImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            weaponImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weaponImage.heightAnchor.constraint(equalToConstant: 50),
            weaponImage.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leftAnchor.constraint(equalTo: historyLabel.leftAnchor, constant: -5),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            backgroundImage.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 5),
            backgroundImage.heightAnchor.constraint(equalToConstant: 350),
            backgroundImage.widthAnchor.constraint(equalToConstant: 350)
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
            improveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            improveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            improveButton.heightAnchor.constraint(equalToConstant: 50),
            improveButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
        
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyLabel.bottomAnchor.constraint(equalTo: resultLabel.topAnchor, constant: -10),
            historyLabel.leftAnchor.constraint(equalTo: resultLabel.leftAnchor)
        ])
    }
}

