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
        WeaponModel(image: UIImage(named: "dance")!, name: "☆☆☆Танец бликов Шуни", attackStat: 1632, plusAttack: 121),
        WeaponModel(image: UIImage(named: "karatel")!, name: "☆☆☆Каратель Юнджи", attackStat: 1943, plusAttack: 135),
        WeaponModel(image: UIImage(named: "uteshitelnica")!, name: "☆☆☆Утешительница Джу", attackStat: 1964, plusAttack: 137),
        WeaponModel(image: UIImage(named: "zverolov")!, name: "☆☆☆Звездолов Шогри", attackStat: 2698, plusAttack: 197)
        
    ]
    
}
