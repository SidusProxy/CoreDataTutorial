//
//  ContentView.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
   
    var body: some View {
        NavigationStack{
            VStack{
                ProductList()

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
