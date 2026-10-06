//
//  MainNavScreen.swift
//  Lookout
//
//  Created by Ethan Present on 10/6/26.
//

import SwiftUI


enum MainScreen{
    case dashboard
    case profile
}

struct MainNavScreen: View {
    
    @State var screen: MainScreen = .dashboard
    @State var showAddSheet: Bool = false
    @State var searchResults: String = ""
    
    var vm = ViewModel.shared
    
    var body: some View {
        VStack{
            // MARK: - Main Content
            if screen == .dashboard && vm.jobs.isEmpty{
                DashboardEmpty()
            } else if screen == .dashboard && !vm.jobs.isEmpty{
                DashboardFirstRun(searchResults: $searchResults)
            } else if screen == .profile{
                Spacer()
                Text("Not Yet Implemented")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            
            // nav bar
            Divider()
                .padding(.vertical, 5)
            HStack{
                Spacer()
                
                // MARK: - Dashboard
                Button{
                    withAnimation {
                        screen = .dashboard
                    }
                } label: {
                    VStack{
                        Image(systemName: "rectangle.grid.2x2")
                            .font(.title)
                        Text("Dashboard")
                            .font(.footnote)
                    }
                    .foregroundStyle(.black)
                }
                
                Spacer()
                
                // MARK: - Add screen
                Button {
                    
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding()
                            .background {
                                Circle()
                                    .fill(.black)
                                    
                            }
                            .shadow(radius: 5)
                    }
                    .simultaneousGesture(
                        LongPressGesture(minimumDuration: 2)
                            .onEnded{ _ in
                                vm.clearJobList()
                            }
                    )
                    // TODO: Remove tap gesture and add as regular button action. This is only here for the demo
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded{ _ in
                                showAddSheet = true
                            }
                    )
                
                Spacer()
                
                // MARK: -  Profile
                Button{
                    withAnimation {
                        screen = .profile
                    }
                } label: {
                    VStack{
                        Image(systemName: "person.crop.circle")
                            .font(.title)
                        Text("Profile")
                            .font(.footnote)
                    }
                    .foregroundStyle(.black)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
//            .border(.blue)
            
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .sheet(isPresented: $showAddSheet) {
            SheetView()
        }
//        .border(.black)
    }
}

struct SheetView: View{
    @Environment(\.dismiss) private var dismiss
    var vm = ViewModel.shared
    
    var body: some View{
        VStack{
            HStack{
                CButton(text: "Close", buttonType: .white, leadingImage: Image(systemName: "xmark")) {
                    dismiss()
                }
                Spacer()
            }
            Spacer()
            
            
            Text("Coming Soon")
                .font(.title)
                .fontWeight(.bold)
            Text("In the future, you will be able to paste a link here to quickly add a job posting in addition to manually adding them. Right now the only feature is to manually add them.")
            
            CButton(text: "Enter details by hand", buttonType: .white, fullWidth: true) {
                // TODO: Navigate to add screen
                vm.go(to: .addScreen)
            }
            
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    MainNavScreen()
//    SheetView()
}
