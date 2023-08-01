//
//  PersistenceController.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import Foundation
import CoreData
struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview : PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        do{
            try viewContext.save()
        }catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError) , \(nsError.userInfo)" )
        }
        return result
    }()
    var container : NSPersistentCloudKitContainer
    
    init(inMemory : Bool = false) {
        container = NSPersistentCloudKitContainer(name: "TodoModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler : {(storeDescription,error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error) , \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        
    }
    
    
}
