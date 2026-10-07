//
//  SearchBar.swift
//  Lookout
//
import SwiftUI

/// A simple searchbar that features a magnifying glass and optional text
struct SearchBar: View {
    /// the text the user enters
    @Binding var text: String
    /// the icon displayed on the lefthand side
    var icon: String = "magnifyingglass"
    /// the default text displayed
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
    @Previewable @State var text: String = ""
    
    SearchBar(text: $text, icon: "magnifyingglass", placeholder: "Search 2")
}
