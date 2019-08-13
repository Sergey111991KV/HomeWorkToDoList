//
//  String-extensions.swift
//  HomeWorkToDoList
//
//  Created by Сергей Косилов on 11.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation

extension String{
    var capitalizedWithSpaces: String{
        let withSpaces = reduce(" ") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
            
        }
        return withSpaces.capitalized 
    }
    var returnKey: String{
        let withSpaces = reduce(" ") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
            
        }
        return withSpaces.capitalized
    }}
