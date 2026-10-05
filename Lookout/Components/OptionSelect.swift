//
//  OptionSelect.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

struct OptionSelect: View {
    let title: String
    let subTitle: String

    @Binding var isSelected: Bool
    
    var onPress: ((Bool) -> Void)? = nil

    var body: some View {
        Button {
            isSelected.toggle()
            onPress?(isSelected)
        } label: {
            HStack(spacing: 24) {
                // Radio button
                ZStack {
                    Circle()
                        .stroke(
                            isSelected ? Color.primary : Color.gray.opacity(0.3),
                            lineWidth: 4
                        )
                        .frame(width: 30, height: 30)

                    if isSelected {
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 15, height: 15)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(subTitle)
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text(title)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        isSelected
                        ? Color.gray.opacity(0.08)
                        : Color.white
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        isSelected
                        ? Color.primary
                        : Color.gray.opacity(0.3),
                        lineWidth: isSelected ? 3 : 2
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    
}
