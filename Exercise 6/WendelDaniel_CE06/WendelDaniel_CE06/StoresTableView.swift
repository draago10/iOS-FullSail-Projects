//
//  StoresTableView.swift
//  WendelDaniel_CE06
//
//  Created by Daniel Wendel on 5/14/21.
//

import UIKit

class StoresTableView: UITableViewController, UITextFieldDelegate {
    
    var store = GroceryStore()
    var cellId = "CellID"
    var saveAction : UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = true
        self.navigationItem.title = store.storeName
        let headerNib = UINib.init(nibName: "StoreVCHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "storeHeader")
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        let alertController = UIAlertController(title: "New Item", message: "Enter the item name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .allEditingEvents)
            textField.placeholder = "Item Name"
        }
        let action = UIAlertAction(title: "Ok", style: .default) { [self] action in
            if let textfield = alertController.textFields?.first?.text{
                self.store.itemsNeeded.append(textfield)
            }
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        self.saveAction = action
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func editTapped(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashTapped))
        } else {
            
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func trashTapped(){
        if var selectedIP = tableView.indexPathsForSelectedRows{
            selectedIP.sort { a, b in a.row > b.row}
            for indexPath in selectedIP{
                if indexPath.section == 0{
                    self.store.itemsNeeded.remove(at: indexPath.row)
                }else{
                    self.store.purchasedItems.remove(at: indexPath.row)
                }
            }
            self.tableView.deleteRows(at: selectedIP, with: .fade)
            self.tableView.reloadData()
        }
    }
    
    
    @objc func textChanged(_ sender:UITextField) {
        if sender.text?.isEmpty == true{
            self.saveAction?.isEnabled = false
        }else {
            self.saveAction?.isEnabled = true
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return store.list.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let alert = UIAlertController(title: "Delete \(store.list[indexPath.section][indexPath.row])?", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { a in
                if indexPath.section == 0{
                    self.store.itemsNeeded.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadData()
                } else {
                    self.store.purchasedItems.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadData()
                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.list[section].count
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "storeHeader") as? StoreHeader
        header?.totalItems.text = "Total Items: \(store.list[section].count.description)"
        header?.editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItems = store.list[indexPath.section][indexPath.row]
        //print(listItems)
        if tableView.isEditing != true{
            if indexPath.section == 0{
                store.itemsNeeded.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                store.purchasedItems.append(listItems)
                tableView.reloadData()
            }else {
                store.purchasedItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                store.itemsNeeded.append(listItems)
                tableView.reloadData()
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Items Needed"
        case 1:
            return "Purchased Items"
        default:
            return "Invaid Section"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? GroceryCell
        else{return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)}
        
        cell.storeName.text = store.list[indexPath.section][indexPath.row]
        
        return cell
    }
    
}
