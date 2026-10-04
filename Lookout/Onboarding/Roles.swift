//
//  Roles.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

struct Roles: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text("What roles are you going for?")
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("We'll tag your applications so your dashboard stays sorted. Pick as many as you like.")
                .font(.callout)
                .foregroundStyle(.gray)
             
            SearchBar(text: $text, icon: "magnifyingglass", placeholder: "Search roles")
                .padding()
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Chip(text: "Product Manager", chipType: .black)
                    Chip(text: "Data Analyst", chipType: .black)
                }

                HStack {
                    Chip(text: "UX Researcher", chipType: .black)
                    Chip(text: "Software Engineer", chipType: .white)
                }

                HStack {
                    Chip(text: "Consulting", chipType: .white)
                    Chip(text: "Marketing", chipType: .white)
                }

                HStack {
                    Chip(text: "Product Designer", chipType: .white)
                    Chip(text: "Business Analyst", chipType: .white)
                }

                HStack {
                    Chip(text: "Finance", chipType: .white)
                    Chip(
                        text: "Other",
                        chipType: .bordered,
                        leadingImage: Image(systemName: "plus")
                    )
                }
            }
            .padding(.horizontal)
            Spacer()
            CButton(text: "Continue", buttonType: .black, fullWidth: true, cornerRadius: 8){}
                .padding()
        }
    }
}

#Preview {
    Roles()
}
