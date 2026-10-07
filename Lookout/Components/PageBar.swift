//
//  PageBar.swift
//  Lookout
//
//  Created by Brett Sestak on 10/6/26.
//

import SwiftUI

/// Displays which page of the onboarding process the user is in. Every bar up to and including current page will be filled in black while the rest are light gray
struct PageBar: View {
    /// the current page the user is on
    let currentPage: Int
    /// the total number of bars to be displayed
    let totalPages: Int
    /// whether or not to show the back button
    let showBack: Bool
    var onBack: (() -> Void)? = nil

    var body: some View {
        HStack {
            if showBack {
                Button {
                    onBack?()
                } label: {
                    Image(systemName: "lessthan")
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.black)
                }
            }
            ForEach(1...totalPages, id: \.self) { index in
                Capsule()
                    .foregroundStyle(
                        index <= currentPage ? .black : .secondary
                    )
                    .frame(height: 5)
            }
            Text("Skip")
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    PageBar(currentPage: 1, totalPages: 4, showBack: true)
}
