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
    var isCheckDatePickerShown: Bool = false{
        didSet{
        tableView.reloadRows(at: [IndexPath(row: 1, section: 2)], with: .automatic)
    }
    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       todo.isComplete.toggle()
//        print(todo.title)
//
//}
}

//MARK: -  UITableViewDataSource
extension ToDoItemTableViewController /*UITableViewDataSource*/{
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let value = todo.values[indexPath.section]
        if value is Date && indexPath.row == 1{
           // let section = todo.values[indexPath.section]
          
                if isCheckDatePickerShown == false{
            
                        return UITableView.automaticDimension } else{
                        return 0
                    }
                   
            
                
            
        } else { return UITableView.automaticDimension }
    
    }

        
    
    
    
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
//MARK: - UITableViewDelegate
extension ToDoItemTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = todo.values[indexPath.section]
        if value is Date{
            isCheckDatePickerShown.toggle()
            
        } else if value is UIImage{
            let alert = UIAlertController(title: "Chose image", message: nil, preferredStyle: .actionSheet)
            let cansel = UIAlertAction(title: "Cansel", style: .cancel)
            alert.addAction(cansel)
            let imagePicker = SectionPickerController()
            imagePicker.delegate = self
            imagePicker.section = indexPath.section
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true)
                }
                alert.addAction(cameraAction)
            }
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true)
                }
                alert.addAction(photoLibrary)
            }
            present(alert, animated: true)
        }
    }
}


//MARK: - Cell Configureter
extension ToDoItemTableViewController {
    func getCell(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        if let stringValue = value as? String{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.textFieldCell.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textFieldCell.section = indexPath.section
            cell.textFieldCell.text = stringValue
            return cell
            
        } else if let dateValue = value as? Date{
            
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
                cell.setDate(dateValue)
                return cell
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
                cell.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
                cell.datePicker.date = dateValue
                cell.datePicker.minimumDate = Date()
                cell.datePicker.section = indexPath.section
                cell.datePicker.isHidden = self.isCheckDatePickerShown
                return cell
            default:
                fatalError("Please add more prototype Cell for date value")
            }
            
        } else if let boolValue = value as? Bool{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.switch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            cell.switch.isOn = boolValue
            cell.switch.section = indexPath.section
            return cell
            
        }else if let imageValue = value as? UIImage{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.largeImageView.image = imageValue
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
             cell.textFieldCell.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textFieldCell.text = ""
            cell.textFieldCell.section = indexPath.section
            return cell
            
        }
       
    }
}

//MARK: - Action
extension ToDoItemTableViewController {
    
    @objc  func textFieldValueChanged(_ sender: SectionTextField){
       let key = todo.keys[sender.section!]
       let text = sender.text ?? ""
       todo.setValue(text, forKey: key)
    }
    
    @objc  func switchValueChanged(_ sender: SectionSwitch){
        let key = todo.keys[sender.section!]
        let text = sender.isOn
        todo.setValue(text, forKey: key)
        
        
    }
    
    @objc  func datePickerValueChanged(_ sender: SectionDatePicker){
       let section = sender.section!
       let key = todo.keys[section]
       let date = sender.date
       todo.setValue(date, forKey: key)
       let indexLabelValue = IndexPath(row: 0, section: section)
        tableView.reloadRows(at: [indexLabelValue], with: .middle)
    
    }
    
}

extension ToDoItemTableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let sectionPicker = picker as? SectionPickerController else { return }
        guard let section = sectionPicker.section else { return }
        let key = todo.keys[section]
        todo.setValue(image, forKey: key )
        let indexPath = IndexPath(row: 0, section: section)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
}
extension ToDoItemTableViewController: UINavigationControllerDelegate {}
