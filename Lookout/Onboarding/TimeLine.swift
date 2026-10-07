//
//  TimeLine.swift
//  Lookout
//
import SwiftUI

struct TimeLine: View {

    var vm = ViewModel.shared

    @State private var graduationDate = Date()
    @State private var offerDate = Date()
    
    @State private var isStarting = false
    @State private var isAlready = false
    @State private var isInterviewing = false
    
    var body: some View {
        VStack {
            PageBar(currentPage: 2, totalPages: 4, showBack: true) {
                vm.pop()
            }
                .padding()
            Text("Set your timeline")
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
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
                    subTitle: "Just starting",
                    isSelected: $isStarting
                ) { selected in
                    if selected {
                        isAlready = false
                        isInterviewing = false
                    }
                }
                
                OptionSelect(
                    title: "Sent out a few applications",
                    subTitle: "Already applying",
                    isSelected: $isAlready
                ) { selected in
                    if selected {
                        isStarting = false
                        isInterviewing = false
                    }
                }
                
                OptionSelect(
                    title: "In process with at least one company",
                    subTitle: "Interviewing",
                    isSelected: $isInterviewing
                ) { selected in
                    if selected {
                        isStarting = false
                        isAlready = false
                    }
                }
            }
            .padding()
            Spacer()
            CButton(text: "Continue", buttonType: .black, fullWidth: true, cornerRadius: 8){
                vm.push(.notifications)
            }
                .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TimeLine()
}
