//
//  ViewController + TableView.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 16.07.2022.
//

import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enchantModel.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        let model = enchantModel.history[indexPath.row]
        cell.resultLabel.textColor = model.result ? .systemGreen : .systemYellow
        cell.resultLabel.text = model.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
