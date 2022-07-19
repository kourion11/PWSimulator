//
//  EnchantModel.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 16.07.2022.
//

import UIKit

class EnchantModel {
    
    var maxEnchantLevel = 12
    var enchant = 0
    var chance = 50
    var weaponName: String
    var initialAttack: Int
    var attackStat: Int
    var plusAttack: Int
    var image: UIImage
    var history: [ResultModel] = []
    var buttonIsNotActive = false
    var breakable = true
    var plusChance = 0
    var weaponHere = false
    
    init(image: UIImage, weaponName: String, attackStat: Int, plusAttack: Int) {
        self.image = image
        self.weaponName = weaponName
        self.initialAttack = attackStat
        self.attackStat = attackStat
        self.plusAttack = plusAttack
    }
    
    func result() {
        if weaponHere {
            let improveChance = Int.random(in: 0...100)
            if enchant < maxEnchantLevel {
                if improveChance <= (chance + plusChance) {
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
            print(improveChance)
        }
    }
    
    func successEnchant() {
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
        if breakable {
            enchant = 0
            chance = 50
            attackStat = initialAttack
            let result = ResultModel(
                text: "Уровень совершенства упал до \(enchant).",
                result: false)
            history.insert(result, at: 0)
            failedEnchantVibration()
        } else {
            enchant -= 1
            chance += 3
            attackStat -= plusAttack
            let result = ResultModel(
                text: "Уровень совершенства упал до \(enchant).",
                result: false)
            history.insert(result, at: 0)
            failedEnchantVibration()
        }
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
