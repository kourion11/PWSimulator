//
//  EnchantModel.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 16.07.2022.
//

import UIKit

class EnchantModel {
    
    var weapons: [WeaponModel] = [
        WeaponModel(image: UIImage(named: "hunter")!, name: "☆☆☆Охотник Джоли", attackStat: 1366, plusAttack: 113),
        WeaponModel(image: UIImage(named: "blooder")!, name: "☆☆☆Кровопийца Инчи", attackStat: 1947, plusAttack: 136),
        WeaponModel(image: UIImage(named: "dance")!, name: "☆☆☆Танец бликов Шуни", attackStat: 1632, plusAttack: 121)
    ]
    
    var maxEnchantLevel = 12
    var enchant = 0
    var chance = 50
    var weaponName = "☆☆☆Охотник Джоли"
    var initialAttack = 1366
    var attackStat = 1366
    var plusAttack = 113
    var image = UIImage(named: "hunter")
    var history: [ResultModel] = []
    var buttonIsNotActive = false
    
//    let weaponList = WeaponList()
    
    func result() {
        let improveChance = Int.random(in: 0...100)
        if enchant < maxEnchantLevel {
            if improveChance <= chance {
                successEnchant()
            } else {
                if enchant > 0 && attackStat >= initialAttack {
                    failedEnchant()
                } else {
                    noResult()
                }
            }
        } else {
            buttonIsNotActive = true
        }
    }
    
    func selectedWeapon(selectRow: Int) {
        print(attackStat)
        let weapon = weapons[selectRow]
        image = weapon.image
        weaponName = weapon.name
        initialAttack = weapon.attackStat
        attackStat = weapon.attackStat
        plusAttack = weapon.plusAttack
    }
    
    func successEnchant() {
        print(attackStat)
        let result = ResultModel(
            text: "Усовершенствование прошло успешно!",
            result: true)
        enchant += 1
        chance -= 3
        attackStat += plusAttack
        history.insert(result, at: 0)
        successEnchantVibration()
    }
    
    func failedEnchant() {
        print(attackStat)
        enchant -= 1
        chance += 3
        attackStat -= plusAttack
        let result = ResultModel(
            text: "Уровень совершенства упал до \(enchant).",
            result: false)
        history.insert(result, at: 0)
        failedEnchantVibration()
    }
    
    func noResult() {
        let result = ResultModel(
            text: "Уровень совершенства не изменился.",
            result: false)
        attackStat = initialAttack
        history.insert(result, at: 0)
        failedEnchantVibration()
    }
    
    func pressButtonVibration() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    func successEnchantVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func failedEnchantVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
