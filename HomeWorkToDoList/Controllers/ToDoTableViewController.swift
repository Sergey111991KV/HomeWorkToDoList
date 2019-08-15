//
//  ToDoTableViewController.swift
//  HomeWorkToDoList
//
//  Created by Сергей Косилов on 10.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = [ToDo]()
   
    var bounds = CGSize()
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [
            ToDo(title: "Построить дом", image: UIImage(named: "Home")),
            ToDo(title: "Воспитать сына", image: UIImage(named: "Son")),
            ToDo(title: "Посадить дерево", image: UIImage(named: "Tree"))
        ]
        bounds = view.bounds.size
        print("helloy")
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.bounds = size
        tableView.reloadData()
        
    }
    
    //MARK: - UITableViewDataSource
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        let todo = todos[indexPath.row]
      
        let size = self.bounds
        
        let isVertical = size.width < size.height
        cell.stackView.axis = isVertical ? .vertical : .horizontal
        configure(cell, with: todo)
        return cell
    }
    
    //MARK: - Cell Content
    func configure(_ cell: ToDoCell, with todo: ToDo) {
        guard let stackViewFirst = cell.firstStack else { return }
        guard let stackViewSecond = cell.secondStack else { return }
        if stackViewFirst.arrangedSubviews.count == 0 {
        for index in 0..<todo.keys.count{
            let key = todo.capitalizesKeys[index]
            let value = todo.values[index]
            
            if let valueString = value as? String{
                let label = UILabel()
                label.text = "\(key) : \(valueString)"
                stackViewFirst.addArrangedSubview(label)
                
            } else if let dateValue = value as? Date{
                let label = UILabel()
                label.text = "\(key) : \(dateValue.formattedDate)"
                stackViewFirst.addArrangedSubview(label)
                
            }else if let boolValue = value as? Bool{
                let label = UILabel()
                label.text = "\(key) : \(boolValue ? "✳️" : "⭕️")"
                stackViewFirst.addArrangedSubview(label)
                }
            }
        } else{
            
            for view in stackViewFirst.arrangedSubviews {
                if let label = view as? UILabel{
                    for index in 0..<todo.keys.count{
                        let key = todo.capitalizesKeys[index]
                        let value = todo.values[index]
                        if label.text?.returnKey == key.trimmingCharacters(in: .whitespaces){
                             print("!!!!!!!!!")
                            if let valueString = value as? String{
                                
                                label.text = "\(key) : \(valueString)"
                                
                            }else if let dateValue = value as? Date{
                               
                                label.text = "\(key) : \(dateValue.formattedDate)"
                                
                                
                            }else if let boolValue = value as? Bool{
                                
                                label.text = "\(key) : \(boolValue ? "✳️" : "⭕️")"
                               
                            }
                        }else{ print(label.text!.count, key.trimmingCharacters(in: .whitespaces).count)}
                    }
                  }
                }
            }
        if stackViewSecond.arrangedSubviews.count == 0 {
        
            for index in 0..<todo.keys.count{
             
                let value = todo.values[index]
                if let imageValue = value as? UIImage{
                let imageView = UIImageView(image: imageValue)
                imageView.contentMode = .scaleAspectFit
                let heightConstraint = NSLayoutConstraint(
                    item: imageView ,
                    attribute: .height,
                    relatedBy: .equal ,
                    toItem: nil ,
                    attribute: .height,
                    multiplier: 1,
                    constant: 200)
                imageView.addConstraint(heightConstraint)
                stackViewSecond.addArrangedSubview(imageView)
                
                }
            }
        } else{
            if let lastImageView = stackViewSecond.arrangedSubviews.last as? UIImageView{
                for index in 0..<todo.keys.count{
                    let value = todo.values[index]
                    if let imageValue = value as? UIImage{
                        let imageView = UIImageView(image: imageValue)
                        imageView.contentMode = .scaleAspectFit
                        let heightConstraint = NSLayoutConstraint(
                            item: imageView ,
                            attribute: .height,
                            relatedBy: .equal ,
                            toItem: nil ,
                            attribute: .height,
                            multiplier: 1,
                            constant: 200)
                        lastImageView.image = imageView.image
                    }
                }
            }
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToDoItemSegue" else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return  }
        let destination = segue.destination as! ToDoItemTableViewController
        destination.todo = todos[selectedIndex.row].copy() as! ToDo
        print(todos[selectedIndex.row].copy())
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue"  else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return  }
        let source = segue.source as! ToDoItemTableViewController
        todos[selectedIndex.row] = source.todo
        print(selectedIndex.row)
        tableView.reloadData()
       // tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
        
    
}
