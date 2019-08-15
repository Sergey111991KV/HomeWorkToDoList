 //
//  DateCell.swift
//  HomeWorkToDoList
//
//  Created by Сергей Косилов on 13.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    func setDate(_ date: Date){
        
        dateLabel.text = date.formattedDate
    }
}
