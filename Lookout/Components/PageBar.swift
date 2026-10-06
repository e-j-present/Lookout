//
//  PageBar.swift
//  Lookout
//
//  Created by Brett Sestak on 10/6/26.
//

import SwiftUI

struct PageBar: View {
    let currentPage: Int
    let totalPages: Int
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
