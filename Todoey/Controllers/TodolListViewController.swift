//
//  ViewController.swift
//  Todoey
//
//  Created by 歐軒忠 on 2018/11/5.
//  Copyright © 2018 歐軒忠. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory : Category? {

        didSet {

            loadItems()

        }

    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

 
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark-增加新Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "增加新項目", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "加入項目", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "輸入新項目"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()

//        let predicate = NSPredicate(format: "parentCategory.name %@", selectedCategory!.name!)
//        
//        request.predicate = predicate
        
        
        do {
            
            itemArray = try context.fetch(request)
            
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        tableView.reloadData()
        
    }

}

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.predicate = predicate
        
        do {
            
            itemArray = try context.fetch(request)
            
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            tableView.reloadData()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
                
            }
            
        }
        
    }
    
}

