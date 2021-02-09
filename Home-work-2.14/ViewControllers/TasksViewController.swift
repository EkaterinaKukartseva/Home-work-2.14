//
//  TasksViewController.swift
//  Home-work-2.14
//
//  Created by EKATERINA  KUKARTSEVA on 09.02.2021.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    
    var taskList: TaskList!
    
    var currentTask: Results<Task>!
    var completedTask: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = taskList.name
        currentTask = taskList.tasks.filter("isComplete = false")
        completedTask = taskList.tasks.filter("isComplete = true")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? currentTask.count : completedTask.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Current Tasks" : "Completed Task"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        
        let task = indexPath.section == 0 ? currentTask[indexPath.row] : completedTask[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        content.secondaryText = task.note
        cell.contentConfiguration = content

        return cell
    }
    
    @objc
    private func addButtonPressed() {
        showAlert()
    }

}

extension TasksViewController {
    
    private func showAlert() {
        
        let alert = AlertController(title: "New Task", message: "What do you want to do?", preferredStyle: .alert)
        
        alert.actionWithTask { newValue, note in
            let task = Task(value: [newValue, note])
            
            StorageManager.shared.saveTask(task: task, in: self.taskList)
            let indexPath = IndexPath(row: self.currentTask.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        present(alert, animated: true)
    }
    
}
