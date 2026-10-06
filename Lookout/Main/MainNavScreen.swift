//
//  MainNavScreen.swift
//  Lookout
//
//  Created by Ethan Present on 10/6/26.
//

import SwiftUI


enum MainScreen{
    case dashboardEmpty
    case dashboard
    case add
    case profile
}

struct MainNavScreen: View {
    
    @State var screen: MainScreen = .dashboardEmpty
    @State var showAddSheet: Bool = false
    
    var body: some View {
        VStack{
            // MARK: - Main Content
            switch screen {
            case .dashboardEmpty:
                DashboardEmpty()
            case .dashboard:
                DashboardFirstRun(searchResults: .constant(""))
            case .add:
                EmptyView()
            default:
                Text("Not Yet Implemented")
            }
            
            
            // nav bar
            Divider()
                .padding(.vertical, 5)
            HStack{
                Spacer()
                
                // MARK: - Dashboard
                Button{
                    withAnimation {
                        screen = screen == .dashboard ? .dashboardEmpty : .dashboard
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
                    showAddSheet = true
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
                
                Spacer()
                
                // MARK: -  Profile
                Button{
                    
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
            FirstApplication()
        }
//        .border(.black)
    }
}

#Preview {
    MainNavScreen()
}
