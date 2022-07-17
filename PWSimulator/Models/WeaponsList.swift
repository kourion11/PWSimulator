//
//  WeaponsList.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 17.07.2022.
//

import UIKit

struct WeaponsList {
    
    var weapons: [WeaponModel] = [
        WeaponModel(image: UIImage(named: "hunter")!, name: "☆☆☆Охотник Джоли", attackStat: 1366, plusAttack: 113),
        WeaponModel(image: UIImage(named: "blooder")!, name: "☆☆☆Кровопийца Инчи", attackStat: 1947, plusAttack: 136),
        WeaponModel(image: UIImage(named: "dance")!, name: "☆☆☆Танец бликов Шуни", attackStat: 1632, plusAttack: 121)
        ]
    
    var enchantModel = EnchantModel()
    
    mutating func selectedWeapon(selectRow: Int) {
        enchantModel.enchant = 0
        enchantModel.image = weapons[selectRow].image
        enchantModel.initialAttack = weapons[selectRow].attackStat
        enchantModel.plusAttack = weapons[selectRow].plusAttack
        print(enchantModel.initialAttack)
    }
}
