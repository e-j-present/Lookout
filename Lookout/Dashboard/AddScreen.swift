//
//  AddScreen.swift
//  Lookout
//
import SwiftUI

struct AddScreen: View {
    @State var roleText: String = ""
    @State var companyText: String = ""
    @State var sourceText: String = ""
    
    let vm = ViewModel.shared
    @State var selectedStage: JobStatus = .saved
    @State var date = Date()
    @State private var isOn = false
    private let hasError: Bool
    private let showTop: Bool
    
    init(
        roleText: String = "",
        companyText: String = "",
        sourceText: String = "",
        selectedStage: JobStatus = .saved
    ) {
        showTop = roleText != ""
        hasError = roleText == "error"
        _roleText = State(initialValue: roleText == "error" ? "" : roleText)
        _companyText = State(initialValue: companyText)
        _sourceText = State(initialValue: sourceText)
        _selectedStage = State(initialValue: selectedStage)
    }
    
    var body: some View {
        VStack(spacing: 15){
            HStack {
                Button {
                    vm.pop()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.black)
                        .font(.title2)
                }
                Spacer()
                Text("New Application")
                    .bold()
                    .font(.title2)
                Spacer()
                Spacer()
            }
            
            if showTop {
                VStack(alignment: .leading, spacing: 4) {
                    if hasError {
                        Text("We couldn't read that link")
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                        
                        Text("Manually add the details below")
                    } else {
                        Text("Found it on Indeed")
                            .fontWeight(.semibold)
                        Text("We filled in the details below.")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray6))
                )
            }
            
            CTextField(label: "Company", placeholder: "Enter the company name", text: $companyText, inputType: .genericText)
            
            CTextField(label: "Role", placeholder: "Enter your role", text: $roleText, inputType: .genericText)
            
            CTextField(label: "Source", placeholder: "Where did you find this job?", text: $sourceText, inputType: .genericText)
            
            VStack(alignment: .leading){
                Text("Stage")
                
                FlowLayout{
                    ForEach(JobStatus.allCases, id: \.self){ status in
                        Chip(text: status.label, chipType: selectedStage == status ? .black : .white){
                            withAnimation {
                                selectedStage = status
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            DateDropdown(date: $date, title: "Application deadline (optional)")
            
            HStack {
                Text("Remind me 2 days before")
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                Toggle("", isOn: $isOn)
                    .tint(.black)
            }
            
            Spacer()
            
            HStack{
                CButton(text: "Save application", buttonType: .black, fullWidth: true) {
                    vm.createJob(job: Job(
                        role: roleText,
                        company: companyText,
                        source: JobSource.stringToJobSource(sourceText),
                        status: selectedStage))
                    vm.pop()
                }
                Spacer()
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {   
    AddScreen(roleText: "error", companyText: "", sourceText: "", selectedStage: .saved)
}
