//
//  MainNavScreen.swift
//  Lookout
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
            // MARK: - nav bar
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showAddSheet) {
            SheetView()
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct SheetView: View{
    @Environment(\.dismiss) private var dismiss
    var vm = ViewModel.shared
    
    @State var text: String = ""
    
    var body: some View{
        VStack{
            HStack{
                Text("Add application")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            .padding(.vertical)
            
            Text("Paste a link from LinkedIn, Indeed, or Handshake.")
                .fontWeight(.light)
                .foregroundStyle(.gray)
                .padding(.vertical)
            CTextField(label: "Job link", placeholder: "Paste a job link", text: $text, inputType: .url)
            
            HStack {
                VStack {
                    Text("Link on your clipboard                    ")
                        .fontWeight(.light)
                        .foregroundStyle(.gray)
                    Text("indeed.com/viewjob?jk=8f2a91c")
                }
                Spacer()
                CButton(text: "Use", buttonType: .black){
                    text = "indeed.com/viewjob?jk=8f2a91c"
                }
            }
            .padding(.vertical)
            
            Text("-------------------- or --------------------")
                .padding()
            
            CButton(text: "Enter details by hand", buttonType: .white, fullWidth: true) {
                dismiss()
                vm.push(.addScreen(roleText: "", companyText: "", sourceText: "", selectedStage: .saved))
            }
            CButton(text: "Continue", buttonType: .black, fullWidth: true) {
                if text != "" {
                    dismiss()
                    if text == "indeed.com/viewjob?jk=8f2a91c" {
                        vm.push(.addScreen(roleText: "Product Analyst", companyText: "Dell Technologies", sourceText: "Indeed", selectedStage: .applied))
                    } else {
                        vm.push(.addScreen(roleText: "error", companyText: "", sourceText: "", selectedStage: .applied))
                    }
                }
            }
            .opacity(text == "" ? 0.25 : 1.0)
            Spacer()
        }
        .padding()
    }
}

#Preview {
   MainNavScreen()
  //  SheetView()
}
