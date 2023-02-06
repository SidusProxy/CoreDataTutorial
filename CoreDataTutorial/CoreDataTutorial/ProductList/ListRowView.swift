//
//  ListRowView.swift
//  CoreDataTutorial
//
//  Created by Gianluca Annina on 06/02/23.
//

import SwiftUI

struct ProductRow: View {
    var name: String
    var expirationDate: Date
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 2){
                Text(name)
                    .font(.system(size: 17))
                Text("\(formatDate(expirationDate: expirationDate, format: "dd MMMM YYYY"))")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            
            Text(checkDates(expirationDate: expirationDate))
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(setColorBy(expirationDate: expirationDate))
        }
        .padding(.vertical, 3)
    }
    
    func formatDate(expirationDate: Date, format: String) -> String{
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = format
        
        return dayFormatter.string(from: expirationDate).capitalized
    }
    
    func compareDates(expirationDate: Date) -> String{
        let expirationDate = Calendar.current.dateComponents([.year,.month,.day], from: expirationDate)
        let currentDate = Calendar.current.dateComponents([.year,.month,.day], from: Date())
        
        let difference: String = "\(Calendar.current.dateComponents([.day], from: expirationDate, to: currentDate))"
        
        return difference.filter("0123456789.".contains)
    }
    
    func checkDates(expirationDate: Date) -> String{
        let dayUntilExpiration: String = compareDates(expirationDate: expirationDate)
        
        if dayUntilExpiration == "0"{
            return "Today"
        } else if dayUntilExpiration == "1" {
            return "Tomorrow"
        } else if expirationDate < Date(){
            return "Expired"
        } else{
            return "In \(compareDates(expirationDate: expirationDate)) Days"
        }
    }
    
    func genrateFutureDate() -> Date{
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 7
        
        return Calendar.current.date(byAdding: dateComponent, to: currentDate) ?? Date()
    }
    
    
    func setColorBy(expirationDate: Date) -> Color{
        let futureDate: Date = genrateFutureDate()
        if expirationDate > futureDate{
            return .green
        } else if expirationDate < futureDate && expirationDate >= Date(){
            return .orange
        } else { return .red }
    }
}

//struct ProductRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductRow(name: String, date: <#Date#>)
//    }
//}
