//
//  DashboardFirstRun.swift
//  Lookout
//
//  Created by Ethan Present on 10/2/26.
//

import SwiftUI

struct DashboardFirstRun: View {
    
    @Binding var searchResults: String
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24){
                // MARK: - Dashboard title and chip for offer goal
                HStack{
                    Text("Dashboard")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Chip(text: "11 wks to offer goal", chipType: .white)
                }
                //            .padding(.horizontal)
                
                // MARK: - You are all set
                VStack(alignment: .leading) {
                    HStack {
                        Text("You're all set, Preston")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "xmark")
                    }
                    
                    Text("Your first application is saved. Tap + to paste your next link, and udpate stages as you hear back.")
                }
                .foregroundStyle(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                    
                )
                //            .padding(.horizontal)
                
                // MARK: - Search and Filter
                HStack{
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.tertiary)
                        TextField("Search Company or role", text: $searchResults)
                    }
                    
                    .padding()
                    .frame(maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.tertiary, lineWidth: 1)
                    )
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .padding()
                            .foregroundStyle(.black)
                            .frame(maxHeight: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(Color(.tertiaryLabel))
                                
                            )
                        
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                
                // MARK: - Analytic squares
                HStack{
                    AnalyticSquare(title: "Applied", count: 0)
                    AnalyticSquare(title: "Interviewing", count: 0)
                    AnalyticSquare(title: "Offers", count: 0)
                }
                .fixedSize(horizontal: false, vertical: true)
                
                
                // MARK: - Reminders
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Due Soon")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(" ")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 50)
                            .foregroundStyle(.quinary)
                        
                        VStack(alignment: .leading){
                            Text("No reminders yet")
                                .fontWeight(.semibold)
                            
                            Text("Add one from any application to get a heads-up before it's due")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.tertiary, style: StrokeStyle(lineWidth: 1, dash: [10]))
                    )
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Applications
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Applications")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("3")
                            .foregroundStyle(.secondary)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack{
                            Chip(text: "All", chipType: .black)
                            Chip(text: "Saved", chipType: .white)
                            Chip(text: "Applied", chipType: .white)
                            Chip(text: "Online assesment", chipType: .white)
                            Chip(text: "Interviewed", chipType: .white)
                        }
                    }
                    
                    VStack{
                        SavedApplicationCard(role: "Associate Product Manager", company: "Google", source: "LinkedIn", reminder: "Added just now", tagText: "Applied", isFavorite: .constant(false))
                        SavedApplicationCard(role: "Associate Product Manager", company: "Dell", source: "LinkedIn", reminder: "Added just now", tagText: "Applied", isFavorite: .constant(true))
                        SavedApplicationCard(role: "Associate Product Manager", company: "Microsoft", source: "LinkedIn", reminder: "Added just now", tagText: "Applied", isFavorite: .constant(false))
                    }
                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.never)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                
            }
            .padding(.vertical)
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    @Previewable @State var searchResults = ""
    DashboardFirstRun(searchResults: $searchResults)
}
