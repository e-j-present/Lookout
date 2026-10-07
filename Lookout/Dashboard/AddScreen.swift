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
    
    var body: some View {
        VStack(spacing: 25){
            Text("Add Job")
                .font(.title)
                .fontWeight(.bold)
            
            CTextField(label: "Role", placeholder: "Enter your role", text: $roleText, inputType: .genericText)
            
            CTextField(label: "Company", placeholder: "Enter the company name", text: $companyText, inputType: .genericText)
            
            CTextField(label: "source", placeholder: "Where did you find this job?", text: $sourceText, inputType: .genericText)
            
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
            
            HStack{
                Spacer()
                CButton(text: "Cancel", buttonType: .white, fullWidth: true) {
                    vm.pop()
                }
                Spacer()
                CButton(text: "Save", buttonType: .black, fullWidth: true) {
                    vm.createJob(job: Job(
                        role: roleText,
                        company: companyText,
                        source: sourceText,
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
    AddScreen()
}
