//
//  DashboardFirstRun.swift
//  Lookout
//
import SwiftUI

struct DashboardFirstRun: View {
    
    @State var showAlert: Bool = true
    @Binding var searchResults: String
    let vm = ViewModel.shared
    var userName: String{
        if let user = vm.loggedInUser{
            return user.name
        }
        return "User"
    }
    @State var savedCount = ViewModel.shared.jobs.filter{$0.status == .saved}.count
    @State var appliedCount = ViewModel.shared.jobs.filter{$0.status == .applied}.count
    @State var onlineAssesmentCount = ViewModel.shared.jobs.filter{$0.status == .onlineAssesment}.count
    @State var interviewingCount = ViewModel.shared.jobs.filter{$0.status == .interviewing}.count
    @State var offerCount = ViewModel.shared.jobs.filter{$0.status == .offer}.count
    
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
                
                // MARK: - You are all set
                if showAlert {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("You're all set, \(userName)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            Button{
                                showAlert = false
                            } label: {
                                Image(systemName: "xmark")
                            }
                        }
                        Text("Your first application is saved. Tap + to paste your next link, and udpate stages as you hear back.")
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }
                
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
                    AnalyticSquare(
                        title: "Applied",
                        count: appliedCount
                    )
                    AnalyticSquare(
                        title: "Interviewing",
                        count: interviewingCount
                    )
                    AnalyticSquare(
                        title: "Offers",
                        count: offerCount
                    )
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
                
                // MARK: - Applications
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Applications")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("\(vm.jobs.count)")
                            .foregroundStyle(.secondary)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack{
                            Chip(text: "All   \(vm.jobs.count)", chipType: .black)
                            Chip(text: "Saved   \(savedCount)", chipType: .white)
                            Chip(text: "Applied   \(appliedCount)", chipType: .white)
                            Chip(text: "Online assesment   \(onlineAssesmentCount)", chipType: .white)
                            Chip(text: "Interviewed   \(interviewingCount)", chipType: .white)
                            Chip(text: "Offers   \(offerCount)", chipType: .white)
                        }
                    }
                    
                    VStack{
                        ForEach(vm.jobs, id: \.self){job in
                            SavedApplicationCard(role: job.role, company: job.company, source: job.source, reminder: "Added just now", tagText: job.status.label, isFavorite: .constant(false))
                        }
                        
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
