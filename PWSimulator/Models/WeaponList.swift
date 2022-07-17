//
//  WeaponList.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 17.07.2022.
//

import UIKit

struct WeaponList {
    
    var weapons: [WeaponModel] = [
        WeaponModel(image: UIImage(named: "hunter")!, name: "☆☆☆Охотник Джоли", attackStat: 1366, plusAttack: 113),
        WeaponModel(image: UIImage(named: "blooder")!, name: "☆☆☆Кровопийца Инчи", attackStat: 1947, plusAttack: 136),
        WeaponModel(image: UIImage(named: "dance")!, name: "☆☆☆Танец бликов Шуни", attackStat: 1632, plusAttack: 121)
    ]
    
}
