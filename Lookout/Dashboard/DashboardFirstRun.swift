//
//  DashboardFirstRun.swift
//  Lookout
//
import SwiftUI

struct DashboardFirstRun: View {
    
    // when using filters, hide the following
    @State var showAnalyticSquare: Bool = true
    @State var showReminders: Bool = true
    @State var showApplicationHeading: Bool = true
    
    @State var showAlert: Bool = true
    @State var showFilterSheet: Bool = false
    @Bindable var vm = ViewModel.shared
    var userName: String{
        if let user = vm.loggedInUser{
            return user.name
        }
        return "User"
    }
    var savedCount = ViewModel.shared.jobs.filter{$0.status == .saved}.count
    var appliedCount = ViewModel.shared.jobs.filter{$0.status == .applied}.count
    var onlineAssesmentCount = ViewModel.shared.jobs.filter{$0.status == .onlineAssesment}.count
    var interviewingCount = ViewModel.shared.jobs.filter{$0.status == .interviewing}.count
    var offerCount = ViewModel.shared.jobs.filter{$0.status == .offer}.count
    
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
                                withAnimation {
                                    showAlert = false
                                }
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
                    // MARK: Search
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.tertiary)
                        TextField("Search company, role, or source", text: $vm.searchText)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        if !vm.searchText.isEmpty {
                            Button{
                                vm.searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color(.tertiaryLabel))
                            }
                        }
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.tertiary, lineWidth: 1)
                    )
                    // MARK: Filter
                    Button{
                        showFilterSheet = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .padding()
                            .foregroundStyle(vm.hasFilters ? .white : .black)
                            .frame(maxHeight: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(vm.hasFilters ? Color.black : Color.white)
                                    .stroke(vm.hasFilters ? Color.clear : Color(.tertiaryLabel), lineWidth: 1)
                            )
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                
                // MARK: - Analytic squares
                if showAnalyticSquare{
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
                }
                // MARK: - Reminders
                if showReminders{
                    VStack(alignment: .leading, spacing: 15){
                        HStack{
                            Text("Due Soon")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("\(vm.reminders.count)")
                                .foregroundStyle(.secondary)
                        }
                        if vm.reminders.isEmpty{
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
                        } else{
                            
                            VStack(spacing: 0) {
                                ForEach(Array(vm.reminders.enumerated()), id: \.element.id) { index, reminder in
                                    ReminderCard(
                                        title: reminder.title,
                                        company: reminder.company,
                                        reminder: reminder.formatRelativeDate(),
                                        month: reminder.getMonthAsName(),
                                        day: reminder.day.description,
                                        alert: reminder.isWithinDays(days: 1) || reminder.isPastDate()
                                    )
                                    .padding(.horizontal)

                                    if index < vm.reminders.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray.opacity(0.3), lineWidth: 1)
                            }
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                // MARK: - Applications
                VStack(alignment: .leading, spacing: 15){
                    
                    if showApplicationHeading{
                        HStack{
                            Text("Applications")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("\(vm.filteredJobs.count)")
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
                    } else{
                        FlowLayout{
                            ForEach(Array(vm.filters), id: \.self){ filter in
                                
                                Chip(text: filter.label, chipType: .black, trailingImage: Image(systemName: "xmark")){
                                    vm.filters.remove(filter)
                                }
                                    .font(.default)
                            }
                            if vm.showFavorites{
                                Chip(text: "Favorites", chipType: .black, leadingImage: Image(systemName: "star.fill"), trailingImage: Image(systemName: "xmark")) {
                                    vm.showFavorites = false
                                }
                            }
                            if !vm.filters.isEmpty{
                                VStack {
                                    Spacer()
                                    Button{
                                        vm.clearFilters()
                                    } label: {
                                        Text("Clear All")
                                            .font(.headline)
                                            .foregroundStyle(.black)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        Text("\(vm.filteredJobs.count) applilcations")
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                    
                    // MARK: Application Cards
                    VStack{
                        ForEach($vm.jobs){$job in
                            if vm.getItemFromFilter(job: job) && vm.matchesSearch(job: job){
                                
                                SavedApplicationCard(role: job.role, company: job.company, source: job.source.label, reminder: "Added just now", tagText: job.status.label, isFavorite: $job.isFavorite){
                                    _, cardAction in
                                    
                                    switch cardAction{
                                    case .cardTapped:
                                        // do nothing for now
                                        break
                                        // add or remove job from favorites list
                                    case .favoriteToggled(let isFavorite):
                                        if isFavorite{
                                            vm.favoriteJobs.append(job)
                                        } else {
                                            vm.favoriteJobs.removeAll { j in
                                                j.id == job.id
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            }
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
        // MARK: - Filter Sheet
        .sheet(isPresented: $showFilterSheet) {
            FilterView()
        }
        // MARK: - Filter View
        .onChange(of: vm.isFiltered) { oldValue, newValue in
            withAnimation {
                showAnalyticSquare = !vm.isFiltered
                showReminders = !vm.isFiltered
                showApplicationHeading = !vm.isFiltered
            }
        }
    }
}

#Preview {
    DashboardFirstRun()
}
