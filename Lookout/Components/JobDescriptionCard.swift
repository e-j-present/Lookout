//
//  JobDescriptionCard.swift
//  Lookout
//
//  Created by Brett Sestak on 10/20/26.
//

import SwiftUI

struct JobDescriptionCard: View {
    let description: String

    @State private var isExpanded = false

    private let collapsedLineLimit = 4

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                Text("Job description")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)

                Spacer()

                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isExpanded.toggle()
                    }
                } label: {
                    Text(isExpanded ? "Show less" : "Show more")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primary)
                }
                .buttonStyle(.plain)
            }

            // Description
            Text(description)
                .font(.system(size: 18))
                .foregroundStyle(.primary)
                .lineLimit(isExpanded ? nil : collapsedLineLimit)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
    }
}

#Preview {
    JobDescriptionCard(
        description: """
        As an Associate Product Manager, you'll partner with engineering, UX, and data science to define product direction, write specs, and ship features used by billions of people. Minimum qualifications include strong analytical skills and experience working with cross-functional teams.
        """
    )
    .padding()
}

