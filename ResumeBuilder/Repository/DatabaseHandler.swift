//
//  DatabaseHandler.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/29/22.
//

import UIKit
import CoreData

class DatabaseHandler {
    private var context : NSManagedObjectContext!
    
    static let shared = DatabaseHandler()
    
    init() {
        context = PersistentStorage.shared.context
    }
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
        let object =  T(entity: entity, insertInto: context)
        return object
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()

        do {
            let result = try context.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete<T: NSManagedObject>(object: T)  {
        context.delete(object)
        save()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
