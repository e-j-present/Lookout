//
//  DateDropdown.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

struct DateDropdown: View {
    @Binding var date: Date
    
    var title: String = "Graduation"
    
    @State private var showingDatePicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.system(size: 18))
                .bold()
            
            Button {
                showingDatePicker = true
            } label: {
                HStack {
                    Text(date.formatted(.dateTime.month(.wide).year()))
                        .font(.system(size: 22))
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 32)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                )
            }
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $showingDatePicker) {
            VStack {
                DatePicker(
                    "Graduation Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()
                
                Button("Done") {
                    showingDatePicker = false
                }
                .font(.headline)
                .padding(.bottom)
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    DateDropdown(
        date: .constant(
            Calendar.current.date(
                from: DateComponents(year: 2027, month: 5)
            )!
        ),
        title: "Graduation"
    )
    .padding()
}
