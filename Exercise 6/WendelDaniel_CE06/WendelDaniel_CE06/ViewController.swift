//
//  ViewController.swift
//  WendelDaniel_CE06
//
//  Created by Daniel Wendel on 5/13/21.
//

import UIKit

class ViewController: UITableViewController, UITextFieldDelegate {
    
    var stores = [GroceryStore]()
    var cellId = "CellID"
    
    var saveAction : UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = true
        accessJson()
        navigationItem.title = "Stores"
        let headerNib = UINib.init(nibName: "CustomHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //UIELEMENT(S)
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    //BUTTON ACTIONS
    @IBAction func editTapped(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            editButton.title = "Back"
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashTapped))
            
        } else {
            editButton.title = "Edit"
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func trashTapped(){
        if var selectedIP = tableView.indexPathsForSelectedRows{
            selectedIP.sort { a, b in a.row > b.row}
            for indexPath in selectedIP{
                stores.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: selectedIP, with: .left)
            
            tableView.reloadData()
        }
    }
    
    //ADD STORE TO LIST
    @objc func addStore(){
        
        let alertController = UIAlertController(title: "New Store", message: "Enter the store name", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .allEditingEvents)
            textField.placeholder = "Store Name"
        }
        
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            if let storeName = alertController.textFields?.first?.text{
                self.createNewStore(storeName: storeName)
            }
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        self.saveAction = action
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func textChanged(_ sender:UITextField) {
        if sender.text?.isEmpty == true{
            self.saveAction?.isEnabled = false
        }else {
            self.saveAction?.isEnabled = true
        }
    }
    
    //MARK: TABLEVIEW METHODS
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete \(self.stores[indexPath.row].storeName)?", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { a in
                self.stores.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CustomHeaderView
        header?.myStoreLabel.text = "My Stores"
        header?.numberOfStores.text = "Number of stores: \(stores.count.description)"
        header?.addButton.addTarget(self, action: #selector(addStore), for: .touchUpInside)
        return header
    }
    
    //GETS RID OF THE UNUSED CELLS FROM THE TABLEVIEW
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? GroceryCell
        else{return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)}
        
        cell.storeName.text = stores[indexPath.row].storeName
        cell.numberOfItems.text = "Needed Items: "  + stores[indexPath.row].itemsNeeded.count.description
        return cell
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !tableView.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow{
            let storeInfo = stores[indexPath.row]
            if let destination = segue.destination as? StoresTableView{
                destination.store = storeInfo
                print(storeInfo)
                
            }
        }
        
    }
    
    
    
}

