//
//  CoreDataManager.swift
//  WendelDaniel_CoreDataProject
//
//  Created by Daniel Wendel on 6/22/21.
//

import CoreData

struct CoreDataManager{
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WendelDaniel_CoreDataProject")
        
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err{
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
}
