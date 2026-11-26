//
//  JobDescriptionCard.swift
//  Lookout
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
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isExpanded.toggle()
                    }
                } label: {
                    Text(isExpanded ? "Show less" : "Show more")
                        .font(.headline)
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
