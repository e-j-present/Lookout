//
//  FilterView.swift
//  Lookout
//
import SwiftUI
struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var vm = ViewModel.shared

    // snapshot of the filters as they were when this screen opened,
    // restored if the user closes with the x instead of confirming
    @State private var savedFilters: Set<JobFilter> = []
    @State private var savedShowFavorites: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            HStack{
                Text("Filter")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                
                Button{
                    // discard anything selected since this screen opened
                    vm.filters = savedFilters
                    vm.showFavorites = savedShowFavorites
                    vm.jobCount = vm.filteredJobs.count
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.secondary)
                }
            }
            
            // MARK: - Job Status
            VStack(alignment: .leading, spacing: 15){
                Text("Stage")
                FlowLayout{
                    ForEach(JobStatus.allCases, id:\.self){ status in
                        Chip(text: status.label, chipType: vm.filters.contains(.status(status)) ? .black : .white){
                            
                            if vm.filters.contains(.status(status)){
                                vm.filters.remove(.status(status))
                            } else {
                                vm.filters.insert(.status(status))
                            }
                        }
                    }
                }
            }
            
            // MARK: - Job Source
            VStack(alignment: .leading, spacing: 15) {
                Text("Source")
                
                FlowLayout{
                    ForEach(JobSource.allCases, id: \.self){ source in
                    
                        Chip(text: source.label, chipType: vm.filters.contains(.source(source)) ? .black : .white){
                            
                            if vm.filters.contains(.source(source)){
                                vm.filters.remove(.source(source))
                            } else{
                                vm.filters.insert(.source(source))
                            }
                        }
                    }
                }
                
            }
            
            Toggle(isOn: $vm.showFavorites) {
                Label {
                    Text("Favorites Only")
                } icon: {
                    Image(systemName: "star.fill")
                }
            }
            .tint(.black)
            
            HStack{
                CButton(text: "Rest", buttonType: .white, fullWidth: false) {
                    withAnimation {
                        vm.clearFilters()
                    }
                }
                CButton(text: "Show \(vm.jobCount) applications", buttonType: .black, fullWidth: true) {
                    dismiss()
                }
                
            }
        }
        .padding(.top, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .onChange(of: vm.filters) { _, _ in
            vm.jobCount = vm.filteredJobs.count
        }
        .onChange(of: vm.showFavorites){ _, _ in
            vm.jobCount = vm.filteredJobs.count
        }
        .onAppear {
            savedFilters = vm.filters
            savedShowFavorites = vm.showFavorites
            vm.jobCount = vm.filteredJobs.count
        }
    }
}

#Preview {
    FilterView()
}
