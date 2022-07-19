//
//  StoneViewController.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 19.07.2022.
//

import UIKit

class StoneViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    var stoneList = StoneList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension StoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stoneList.stones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = stoneList.stones[indexPath.row]
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let presenter = presentingViewController as? ViewController {
            presenter.stoneButton.imageView?.image = presenter.stoneList.stones[indexPath.row].image
            presenter.stoneLabel.text = presenter.stoneList.stones[indexPath.row].discription
            presenter.enchantModel.breakable = presenter.stoneList.stones[indexPath.row].breakable
            presenter.enchantModel.plusChance = presenter.stoneList.stones[indexPath.row].plusChance
        }
        dismiss(animated: true)
    }
}
