//
//  ListView.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//

import SwiftUI

struct ProductList: View {
    var foodCategory: [Category]?
    
    
    @StateObject var modelViewModel:ProductListModelView = ProductListModelView()
    @State var productsArray:[Product] = []
    
    var searchResults: [Product] {
            if modelViewModel.searchText.isEmpty {
                return modelViewModel.filterList(products: productsArray, category: foodCategory)
            } else {
                return productsArray.filter{$0.name.contains(modelViewModel.searchText)}
            }
    }
    
    var body: some View {
        
        VStack{
            List{
                Section{
                    
                    ForEach(searchResults, id: \.self){ product in
                        
                        ProductRow(name: product.name, expirationDate: product.expiryDate)
                        
                    }
                    .onDelete(perform: delete)
                    
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            
            
            
                Spacer()
                Text("\(searchResults.count) food")
                    .font(.system(.callout))
                    .foregroundColor(.gray)
            HStack{
                Button("create", action: {
                    try! PersistenceController.shared.createNewFood(product: Product(name: "TestFood", expiryDate: Date(), isOpened: false, category: .meat))
                    productsArray = try! modelViewModel.getProducts()

                })
            }
        }
        .padding(.top, 3)
        .navigationTitle(foodCategory?[0].name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(UIColor.systemGray6))
        .searchable(text: $modelViewModel.searchText).onAppear(){
            productsArray = try! modelViewModel.getProducts()
        }

        
        
    }
    func delete(at offsets: IndexSet) {
        offsets.sorted(by: > ).forEach { (i) in
            try! modelViewModel.deleteFood(product: searchResults[i])
        }
    }
   
}

//struct ProductList_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductList()
//    }
//}
