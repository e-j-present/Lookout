//
//  ReminderCard.swift
//  Lookout
//
import SwiftUI

/// Basic card used to remind the user of upcoming events
struct ReminderCard: View {
    /// main title of the card.
    var title: String
    /// company name. Displayed under the title and to the left of the reminder
    var company: String
    /// Used to display the due date of the reminder as a string
    var reminder: String
    /// Used to display the due month of the reminder as a date icon
    var month: String
    /// Used to display the due day of the reminder as a date icon
    var day: String
    /// True to turn font red (reminder is due soon), false to keep black
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
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ReminderCard(title: "Take online assessment", company: "Capital One", reminder: "Tomorrow, 11:59 PM", month: "OCT", day: "15", alert: true)
    ReminderCard(title: "Follow up with recruiter", company: "Dell Technologies", reminder: "Mon", month: "OCT", day: "20", alert: false)
}
