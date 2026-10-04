//
//  SearchBar.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var icon: String = "magnifyingglass"
    var placeholder: String = "Search"
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundStyle(.gray)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 22))
        }
        .padding(.horizontal, 32)
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
        )
    }
}

#Preview {
    @State var text: String = ""
    
    SearchBar(text: $text, icon: "magnifyingglass", placeholder: "Search 2")
}
