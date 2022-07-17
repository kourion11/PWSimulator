//
//  EnchantModel.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 16.07.2022.
//

import UIKit

struct EnchantModel {
    
    var maxEnchantLevel = 12
    var enchant = 0
    var chance = 70
    var initialAttack = 1632
    var attackStat = 1632
    var plusAttack = 133
    var image = UIImage(named: "hunter")
    var history: [ResultModel] = []
    var buttonIsNotActive = false
    
    mutating func result() {
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
    
    mutating func successEnchant() {
        let result = ResultModel(
            text: "Усовершенствование прошло успешно!",
            result: true)
        enchant += 1
        chance -= 5
        attackStat += plusAttack
        history.insert(result, at: 0)
        successEnchantVibration()
    }
    
    mutating func failedEnchant() {
        enchant -= 1
        chance += 5
        attackStat -= plusAttack
        let result = ResultModel(
            text: "Уровень совершенства упал до \(enchant).",
            result: false)
        history.insert(result, at: 0)
        failedEnchantVibration()
    }
    
    mutating func noResult() {
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
