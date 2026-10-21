//
//  DetailsCard.swift
//  Lookout
//
import SwiftUI
struct DetailsCard: View {
    struct Detail: Identifiable {
        let id = UUID()
        let title: String
        let value: String
    }
    let title: String
    let details: [Detail]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Card title
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 24)
            
            // Detail rows
            ForEach(Array(details.enumerated()), id: \.element.id) { index, detail in
                
                HStack {
                    Text(detail.title)
                        .foregroundStyle(.secondary)
                    
                    Spacer(minLength: 16)
                    
                    Text(detail.value)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.trailing)
                }
                .font(.body)
                .padding(.vertical, 20)
                
                // Divider between rows, but not after the last one
                if index < details.count - 1 {
                    Divider()
                }
            }
        }
        .padding(24)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
    }
}

#Preview {
    DetailsCard(
    title: "Details",
    details: [
    .init(title: "Source", value: "LinkedIn"),
    .init(title: "Date applied", value: "Sep 30, 2026"),
    .init(title: "Application deadline", value: "Oct 1, 2026"),
    .init(title: "Added", value: "Sep 28, 2026")
    ]
    )
}
