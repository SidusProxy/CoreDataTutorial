//
//  ListViewModelView.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//



import Foundation

extension ProductList{
    class ProductListModelView: ObservableObject{
        
        @Published var searchText = ""
        @Published var productsArray = []
   
        
        init(){
            productsArray = try! getProducts()
        }
        
        func getAllFood() throws -> [FoodEntity]{
            let foodArray:[FoodEntity] = try PersistenceController.shared.fetch(entityName: "FoodEntity")
            return foodArray
        }
        
        func getProducts() throws -> [Product]{
            var productArray:[Product] = []
            let foodArray = try getAllFood()
            for food in foodArray{
                productArray.append(Product(food: food))
            }
            return productArray
        }
        
        func deleteFood(product:Product)throws{
            let foodArray = try getAllFood()
            try PersistenceController.shared.delete(data: foodArray.first(where: {$0.id == product.id})!)
        }
        
        
        
        func delete(at offsets: IndexSet) {
            offsets.sorted(by: > ).forEach { (i) in
                try! deleteFood(product: try getProducts()[i])
            }
            productsArray = try! getProducts()
        }
        
        func filterList(products: [Product], category: [Category]?) -> [Product]{
            if category != nil {
                return filterByCategory(products: products, selectedCategory: category!)
            }else{
                return products
            }
        }
        
        
        func generateFutureDate() -> Date{
            let currentDate = Date()
            var dateComponent = DateComponents()
            dateComponent.day = 7
            
            return Calendar.current.date(byAdding: dateComponent, to: currentDate) ?? Date()
        }
        
        
        func filterByExpirationDate(products: [Product]) -> [Product]{
            let futureDate: Date = generateFutureDate()
            let filteredList = products.filter{$0.expiryDate <= futureDate && $0.expiryDate > Date()}
            
            return sortByExpiryDate(products: filteredList)
        }
        
        func filterByCategory(products: [Product], selectedCategory: [Category]) -> [Product]{
            let filteredList: [Product]
            if selectedCategory.count == 1{
                filteredList = products.filter{$0.category == selectedCategory[0]}
            } else{
                filteredList = products
            }
            
            return sortByExpiryDate(products: filteredList)
        }
        
        
        func sortByExpiryDate(products: [Product]) -> [Product]{
            return products.sorted{$0.expiryDate < $1.expiryDate}
            
        }
    }
}
