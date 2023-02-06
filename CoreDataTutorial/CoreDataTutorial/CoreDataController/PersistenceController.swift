//
//  Persistence.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    
    let container = NSPersistentContainer(name: "CoreDataTutorial")
    
    private init(){
        
        container.loadPersistentStores{ description, error in
        
            if let error = error {
                
                print("Core Data failed to load: \(error.localizedDescription)")
                
                //Handle the error correctly
                
            }
        }
    }
    
    
    
    func fetch<T:NSFetchRequestResult>(entityName:String) throws -> [T] {
      
        let request = NSFetchRequest<T>(entityName: entityName)
        
        let entities = try container.viewContext.fetch(request)
        
        return entities
        
    }
    
    
    func saveContext() throws{
        
        try container.viewContext.save()
        
    }

    func delete<T:NSFetchRequestResult>(data:T) throws{
        
        container.viewContext.delete(data as! NSManagedObject)

        try saveContext()
        
    }
    
    
}
