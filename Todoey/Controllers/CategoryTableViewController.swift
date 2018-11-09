//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by 歐軒忠 on 2018/11/8.
//  Copyright © 2018 歐軒忠. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dvc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            dvc.selectedCategory = categories[indexPath.row]
            
        }
        
    }

    @IBAction func addButtonPredded(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "增加新項目", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "加入項目", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addTextField { (field) in
            
            textField.placeholder = "輸入新項目"
            textField = field
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategories() {
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            
            categories = try context.fetch(request)
            
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        tableView.reloadData()
        
    }
    
}
