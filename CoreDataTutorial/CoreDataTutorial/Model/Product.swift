//
//  Product.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//

import Foundation

struct Product: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var dateCreated = Date()
    var expiryDate: Date
    var isOpened: Bool
    var category: Category
    
    init(name: String, dateCreated: Date = Date(), expiryDate: Date, isOpened: Bool, category: Category) {
        self.name = name
        self.dateCreated = dateCreated
        self.expiryDate = expiryDate
        self.isOpened = isOpened
        self.category = category
    }
    
    init(food:FoodEntity) {
        self.name = food.name ?? ""
        self.dateCreated = food.dateCreated ?? Date()
        self.expiryDate = food.expiryDate ?? Date()
        self.isOpened = food.isOpened
        self.category = Category.getCategory(category: food.category ?? "")
        self.id = food.id ?? UUID()
    }
    
    func copyInEntity(food:FoodEntity){
        food.name = self.name
        food.category = self.category.name
        food.isOpened = self.isOpened
        food.expiryDate = self.expiryDate
        food.dateCreated = self.dateCreated
        food.id = self.id
    }
}

enum Category: CaseIterable {
    case meat
    case fish
    case vegetables
    case fruit
    case others
    
    var name: String {
        switch self {
        case .meat:
            return "Meat"
        case .fish:
            return "Fish"
        case .vegetables:
            return "Vegetables"
        case .fruit:
            return "Fruit"
        case .others:
            return "Others"
        }
    }
    static func getCategory(category:String)->Category{
        if category == "Meat"{
            return .meat
        }else if category == "Fish"{
            return .fish
        }else if category == "Vegetables"{
            return .vegetables
        }else if category == "Fruit"{
            return.fruit
        }else if category == "Others"{
            return .others
        }
        return .others
    }
}




