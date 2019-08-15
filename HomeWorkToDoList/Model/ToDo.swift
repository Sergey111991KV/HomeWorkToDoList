//
//  ToDo.swift
//  HomeWorkToDoList
//
//  Created by Сергей Косилов on 10.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

@objcMembers class ToDo: NSObject {
    
    var title: String
    var isComplete: Bool
    var dueData: Date
    var notes: String?
    var image: UIImage?
    
    
    init(
        title: String = "",
        isComplete: Bool = false,
        dueData: Date = Date(),
        notes: String? = nil,
        image: UIImage? = nil
        ) {
        self.title = title
        self.isComplete = isComplete
        self.dueData = dueData
        self.notes = notes
        self.image = image
    }
    
    var capitalizesKeys : [String]{
        return keys.map { $0.capitalizedWithSpaces }
    }
    
    var keys: [String]{
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any?]{
        return Mirror(reflecting: self).children.map { $0.value }
    }
    
    override func copy() -> Any {
       let newToDo = ToDo(
        title: title,
        isComplete: isComplete,
        dueData: dueData,
        notes: notes,
        image: image?.copy() as? UIImage
        )
        return newToDo
    }
}
