//
//  ReminderCard.swift
//  Lookout
//
//  Created by Ethan Present on 10/2/26.
//

import SwiftUI

struct ReminderCard: View {
    
    var title: String
    var company: String
    var reminder: String
    var month: String
    var day: String
    var alert: Bool
    
    
    var body: some View {
        HStack{
            // MARK: Date
            VStack{
                Text(month)
                    .font(.subheadline)
                Text(day)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(16)
            .foregroundStyle(alert ? .red : .black)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.quinary)
                    .aspectRatio(1, contentMode: .fit)
            )
            
            // MARK: Text
            VStack(alignment: .leading){
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack{
                    Text(company)
                    Text("·")
                    Text(reminder)
                }
                .foregroundStyle(alert ? .red : .black)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

#Preview {
    ReminderCard(title: "Take online assessment", company: "Capital One", reminder: "Tomorrow, 11:59 PM", month: "OCT", day: "15", alert: true)
    
    ReminderCard(title: "Follow up with recruiter", company: "Dell Technologies", reminder: "Mon", month: "OCT", day: "20", alert: false)
}
