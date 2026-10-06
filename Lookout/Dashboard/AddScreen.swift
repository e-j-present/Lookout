//
//  AddScreen.swift
//  Lookout
//
//  Created by Ethan Present on 10/6/26.
//

import SwiftUI

struct AddScreen: View {
    
    @Binding var roleText: String
    @Binding var companyText: String
    @Binding var sourceText: String
    
    
    
    var body: some View {
        VStack(spacing: 25){
            Text("Add Job")
                .font(.title)
                .fontWeight(.bold)
            
            CTextField(label: "Role", placeholder: "Enter your role", text: $roleText, inputType: .genericText)
            
            CTextField(label: "Company", placeholder: "Enter the company name", text: $companyText, inputType: .genericText)
            
            CTextField(label: "source", placeholder: "Where did you find this job?", text: $sourceText, inputType: .genericText)
            
            HStack{
                Spacer()
                
                CButton(text: "Cancel", buttonType: .white, fullWidth: true) {
                    
                }
                
                Spacer()
                
                CButton(text: "Save", buttonType: .black, fullWidth: true) {
                    
                }
                
                Spacer()
            }
        }
        .padding()
        .border(.black)
    }
}

#Preview {
    @Previewable @State var roleText: String = ""
    @Previewable @State var companyText: String = ""
    @Previewable @State var sourceText: String = ""
    
    AddScreen(roleText: $roleText, companyText: $companyText, sourceText: $sourceText)
}
