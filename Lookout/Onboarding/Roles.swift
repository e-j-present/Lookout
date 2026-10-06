//
//  Roles.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

struct Roles: View {
    @State var continueClick = false
    
    @State private var text: String = ""
    
    @State private var manager = false
    @State private var analyst = false
    @State private var researcher = false
    @State private var engineer = false
    @State private var consulting = false
    @State private var marketing = false
    @State private var designer = false
    @State private var business = false
    @State private var finance = false
    
    var body: some View {
        NavigationStack {
            VStack {
                PageBar(currentPage: 1, totalPages: 4, showBack: false)
                    .padding()
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
                        Chip(text: "Product Manager", chipType: manager ? .black : .white) {
                            manager.toggle()
                        }
                        Chip(text: "Data Analyst", chipType: analyst ? .black : .white) {
                            analyst.toggle()
                        }
                    }
                    
                    HStack {
                        Chip(text: "UX Researcher", chipType: researcher ? .black : .white) {
                            researcher.toggle()
                        }
                        Chip(text: "Software Engineer", chipType: engineer ? .black : .white) {
                            engineer.toggle()
                        }
                    }
                    
                    HStack {
                        Chip(text: "Consulting", chipType: consulting ? .black : .white) {
                            consulting.toggle()
                        }
                        Chip(text: "Marketing", chipType: marketing ? .black : .white) {
                            marketing.toggle()
                        }
                    }
                    
                    HStack {
                        Chip(text: "Product Designer", chipType: designer ? .black : .white) {
                            designer.toggle()
                        }
                        Chip(text: "Business Analyst", chipType: business ? .black : .white) {
                            business.toggle()
                        }
                    }
                    
                    HStack {
                        Chip(text: "Finance", chipType: finance ? .black : .white) {
                            finance.toggle()
                        }
                        Chip(
                            text: "Other",
                            chipType: .bordered,
                            leadingImage: Image(systemName: "plus")
                        )
                    }
                }
                .padding(.horizontal)
                Spacer()
                CButton(text: "Continue", buttonType: .black, fullWidth: true, cornerRadius: 8){
                    continueClick.toggle()
                }
                .padding()
                .navigationDestination(isPresented: $continueClick) {
                    TimeLine()
                }
            }
        }
    }
}

#Preview {
    Roles()
}
