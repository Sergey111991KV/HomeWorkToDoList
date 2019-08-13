//
//  Date-Extensions.swift
//  HomeWorkToDoList
//
//  Created by Сергей Косилов on 11.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation

extension Date {
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
