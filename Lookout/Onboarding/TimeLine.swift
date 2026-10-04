//
//  TimeLine.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

struct TimeLine: View {
    @State private var graduationDate = Date()
    @State private var offerDate = Date()
    
    var body: some View {
        VStack {
            Text("Set your timeline")
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("We'll pace reminders and your dashboard around these dates.")
                .font(.callout)
                .foregroundStyle(.gray)
            Text("")
            
            DateDropdown(date: $graduationDate, title: "Graduation")
                .padding(.horizontal)
            DateDropdown(date: $offerDate, title: "I want an offer by")
                .padding(.horizontal)
            VStack(spacing: 20) {
                OptionSelect(
                    title: "Haven't applied anywhere yet",
                    subTitle: "Just starting"
                )
                
                OptionSelect(
                    title: "Sent out a few applications",
                    subTitle: "Already applying"
                )
                
                OptionSelect(
                    title: "In process with at least one company",
                    subTitle: "Interviewing"
                )
            }
            .padding()
            Spacer()
            CButton(text: "Continue", buttonType: .black, fullWidth: true, cornerRadius: 8){}
                .padding()
        }
    }
}

#Preview {
    TimeLine()
}
