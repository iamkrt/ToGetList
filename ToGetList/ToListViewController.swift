//
//  ViewController.swift
//  ToGetList
//
//  Created by kartik yadav on 06/08/18.
//  Copyright © 2018 iamkrt. All rights reserved.
//

import UIKit

class ToListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // first stands for grabbing the first item since it's an array
       
        
       loadItems()
        

//          if let items = defaults.array(forKey: "itemListArray") as? [Item] {
//            itemArray = items
//        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // set the cell.acc type to check if item.done is true.
        
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else if itemArray[indexPath.row].done == false {
            cell.accessoryType = .none
        }
      
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(itemArray[indexPath.row].done)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen when the user clicks the button
            
           let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem) // if field is nil give a default value
            
            self.saveItems()
            
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
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print(error.localizedDescription)
        }

        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error in decoding \(error.localizedDescription)")
            }
        }
    }
    
    
}

