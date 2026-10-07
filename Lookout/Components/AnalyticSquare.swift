//
//  AnalyticSquare.swift
//  Lookout
//

import SwiftUI

/// Component used in the dashboard. Displays the count of jobs with a specific stage
struct AnalyticSquare: View {
    /// title/stage of the component
    let title: String
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(count.description)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .fontWeight(.light)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
        .padding(.horizontal, 8)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1.0)
        )
    }
}

#Preview {
    HStack(spacing: 12){
        AnalyticSquare(title: "Applied", count: 10)
        AnalyticSquare(title: "Interviewing", count: 5)
        AnalyticSquare(title: "Offers", count: 0)
    }
    .padding(.horizontal, 4)
    .fixedSize(horizontal: false, vertical: true)
}
