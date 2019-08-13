//
//  ToDoItemTableViewController.swift
//  HomeWorkToDoList
//
//  Created by Сергей Косилов on 10.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ToDoItemTableViewController: UITableViewController {
    
    //MARK: - Properties
   var todo = ToDo()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       todo.isComplete.toggle()
        print(todo.title)

}
}

//MARK: -  UITableViewDataSource
extension ToDoItemTableViewController /*UITableViewDataSource*/{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todo.keys.count
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = todo.values[section]
        return value is Date ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let value = todo.values[section]
        let cell = getCell(indexPath: indexPath, with: value)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = todo.capitalizesKeys[section]
        return key
    }
}


//MARK: - Cell Configureter
extension ToDoItemTableViewController {
    func getCell(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        if let stringValue = value as? String{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! 
            
        } else if let dateValue = value as? Date{
            
        } else if let boolValue = value as? Bool{
            
        }else if let imageValue = value as? UIImage{
            
        }else {
            
        }
        return UITableViewCell()
    }
}
