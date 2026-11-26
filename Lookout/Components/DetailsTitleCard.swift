//
//  DetailsTitleCard.swift
//  Lookout
//
//  Created by Ethan Present on 11/26/26.
//

import SwiftUI

struct DetailsTitleCard: View {
    var body: some View {
        VStack(spacing: 15){
            
            HStack{
                Text("C")
                    .frame(width: 70, height: 70)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black)
                    )
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading){
                    Text("Assoicate Product Manager")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Google • LinkedIn")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .fontWeight(.medium)
                }
                Spacer()
            }
            
            HStack{
                Chip(
                    text: "Interview 2",
                    chipType: .gray,
                    horizontalPadding: 12,
                    verticalPadding: 8)
                .fontWeight(.bold)
                Text("Updated 2 days ago")
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            HStack{
                Text("linkedin.com/jobs/view/402188284")
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    DetailsTitleCard()
}
