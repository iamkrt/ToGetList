//
//  ViewController.swift
//  ToGetList
//
//  Created by kartik yadav on 06/08/18.
//  Copyright © 2018 iamkrt. All rights reserved.
//

import UIKit

class ToListViewController: UITableViewController {

    var itemArray = [""]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "itemListArray") as? [String] {
            itemArray = items
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen when the user clicks the button
            self.itemArray.append(textField.text ?? "nothing here") // if field is nil give a default value
            
            self.defaults.set(self.itemArray, forKey: "itemListArray")
            
           self.tableView.reloadData()
        }
        
        // adding a text field in action
        
        alert.addTextField { (addItemText) in
            addItemText.placeholder = "Create a new entry"
            textField = addItemText
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}

