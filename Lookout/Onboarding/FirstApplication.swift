//
//  FirstApplication.swift
//  Lookout
//
//  Created by Brett Sestak on 10/5/26.
//

import SwiftUI

struct FirstApplication: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text("Add your first application")
                .font(.system(size: 32))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("Paste a job link and we'll pull the company, role, and source.")
                .font(.callout)
                .foregroundStyle(.gray)
            CTextField(label: "Job link", placeholder: "", text: $text, inputType: .url, hint: "Works with LinkedIn, Indeed, and Handshake links.")
                .padding()
            Text("------------------ or ------------------")
                .font(.callout)
                .foregroundStyle(.gray)
            CButton(text: "Enter details by hand", buttonType: .white, fullWidth: true, cornerRadius: 8){}
                .padding(.horizontal)
            Spacer()
            CButton(text: "Continue", buttonType: .black, fullWidth: true, cornerRadius: 8){}
                .padding()
        }
    }
}

#Preview {
    FirstApplication()
}
