//
//  StoneList.swift
//  PWSimulator
//
//  Created by Сергей Юдин on 19.07.2022.
//

import UIKit

struct StoneList {
    
    let stones: [StoneModel] = [
        StoneModel(image: UIImage(named: "sky")!,
                   name: "Небесный Камень",
                   plusChance: 25,
                   discription: "Шанс успеха +20%",
                   breakable: true),
        StoneModel(image: UIImage(named: "underground")!,
                   name: "Подземный Камень",
                   plusChance: 0,
                   discription: "В случае неудачи -1",
                   breakable: false)
    ]
    
}
