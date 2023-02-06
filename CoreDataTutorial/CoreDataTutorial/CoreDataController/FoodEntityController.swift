//
//  FoodEntityController.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//

import Foundation
import CoreData
extension PersistenceController{
    
    func createNewFood(product:Product) throws{
        
        let newFood = FoodEntity(context: container.viewContext)
        
        product.copyInEntity(food: newFood)
        
        try saveContext()
    }
    
    func fetchFoodUsingCategory(category:String)->[FoodEntity]?{
        
        let request = NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
        
        request.predicate = NSPredicate(format: "category == %@",category)
        
        let operatorentity = try? container.viewContext.fetch(request)
        
        return operatorentity
        
    }
    
}
