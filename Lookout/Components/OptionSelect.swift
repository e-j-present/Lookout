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
    
    @State private var isSelected = false
    
    var body: some View {
        Button {
            isSelected.toggle()
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
                    .fill(isSelected ? Color.gray.opacity(0.08) : Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        isSelected ? Color.primary : Color.gray.opacity(0.3),
                        lineWidth: isSelected ? 3 : 2
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 20) {
        OptionSelect(
            title: "Haven't applied anywhere yet",
            subTitle: "Just starting"
        )
        
        OptionSelect(
            title: "Sent out a few applications",
            subTitle: "Already applying"
        )
        
        OptionSelect(
            title: "In process with at least one company",
            subTitle: "Interviewing"
        )
    }
    .padding()
}
