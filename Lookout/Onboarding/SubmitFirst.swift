//
//  SubmitFirst.swift
//  Lookout
//
//  Created by Brett Sestak on 10/5/26.
//

import SwiftUI

struct SubmitFirst: View {
    @State private var company: String = "Google"
    @State private var role: String = "Associate Product Manager"
    @State private var source: String = "LinkedIn"
    
    @State private var isSaved: Bool = false
    @State private var isApplied: Bool = false
    
    var body: some View {
        VStack(spacing: 1) {
            PageBar(currentPage: 4, totalPages: 4, showBack: true)
                .padding()
            Text("Look right?")
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("Fix anything we got wrong before saving.")
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: 5) {
                Text("")
                Text("Found it on LinkedIn")
                    .bold()
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.horizontal)
                Text("We filled in the details below.")
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.horizontal)
                Text("")
            }
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .padding(.horizontal)
            
            CTextField(label: "Company", placeholder: "", text: $company, inputType: .genericText)
                .padding()
            CTextField(label: "Role", placeholder: "", text: $role, inputType: .genericText)
                .padding()
            CTextField(label: "Source", placeholder: "", text: $source, inputType: .genericText)
                .padding()
            Text("Stage")
                .frame(maxWidth: .infinity ,alignment: .leading)
                .padding()
            HStack {
                Chip(text: "Saved", chipType: isSaved ? .black : .white) {
                    if (isApplied) {
                        isApplied.toggle()
                    }
                    isSaved.toggle()
                }
                Chip(text: "Applied", chipType: isApplied ? .black : .white) {
                    if (isSaved) {
                        isSaved.toggle()
                    }
                    isApplied.toggle()
                }
            }
            .frame(maxWidth: .infinity ,alignment: .leading)
            .padding(.horizontal)
            Spacer()
            CButton(text: "Save application", buttonType: .black, fullWidth: true, cornerRadius: 8){}
                .padding()
        }
    }
}

#Preview {
    SubmitFirst()
}
