//
//  ResultCell.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 15.07.2022.
//

import UIKit

class ResultCell: UITableViewCell {
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(resultLabel)
    }
    
    func setupConstraints() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            resultLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
