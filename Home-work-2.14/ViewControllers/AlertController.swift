//
//  AlertController.swift
//  Home-work-2.14
//
//  Created by EKATERINA  KUKARTSEVA on 09.02.2021.
//

import UIKit

class AlertController: UIAlertController {
    
    var doneDutton = "Save"
        
    func action(with taskList: TaskList?, completion: @escaping (String) -> Void) {
        
        if taskList != nil {
            doneDutton = "Update"
        }
                
        let saveAction = UIAlertAction(title: doneDutton, style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "List Name"
            textField.text = taskList?.name
        }
    }
    
    func actionWithTask(completion: @escaping (String, String) -> Void) {
                        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newTask = self.textFields?.first?.text else { return }
            guard !newTask.isEmpty else { return }
            
            if let note = self.textFields?.last?.text, !note.isEmpty {
                completion(newTask, note)
            } else {
                completion(newTask, "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        
        addTextField { textField in
            textField.placeholder = "New task"
        }
        
        addTextField { textField in
            textField.placeholder = "Note"
        }
    }
}
