//
//  ViewController.swift
//  Todoey
//
//  Created by 歐軒忠 on 2018/11/5.
//  Copyright © 2018 歐軒忠. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["買雞蛋", "買牛奶", "買泡麵"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
//        cell.setSelected(true, animated: true)
        
        return cell
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//
//        tableView.allowsMultipleSelectionDuringEditing = true
//        tableView.allowsSelection = true
//        self.tableView.setEditing(true, animated: false)
//        self.loadViewIfNeeded()
//
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}

