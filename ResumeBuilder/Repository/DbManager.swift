//
//  DbManager.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

protocol DbProtocol {
    func addResumeIntoDb(name: String)
    func getResumesFromDb(completion: @escaping (_ resumes: [Resume]?, _ error: Error?) -> Void)
    func deleteObjectFromDb<T: NSManagedObject>(object: T)
}

class DbManager : DbProtocol {
    
    let handler = DatabaseHandler.shared
    
    func addResumeIntoDb(name: String) {
        guard let resume = handler.add(Resume.self) else { return }
        resume.name = name
        handler.save()
    }
    
    func getResumesFromDb(completion: @escaping ([Resume]?, Error?) -> Void) {
        let results = handler.fetch(Resume.self)
        completion(results, nil)
    }
    
    func deleteObjectFromDb<T: NSManagedObject>(object: T) {
        handler.delete(object: object)
    }
    
}
