//
//  DashboardEmpty.swift
//  Lookout
//
//  Created by Ethan Present on 9/28/26.
//

import SwiftUI

struct DashboardEmpty: View {
    var body: some View {
        
        VStack(spacing: 24){
            // Dashboard title and chip for offer goal
            HStack{
                Text("Dashboard")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                Chip(text: "11 wks to offer goal", chipType: .white)
            }
            .padding(.horizontal)
            
            // Analytic squares
            HStack{
                AnalyticSquare(title: "Applied", count: 0)
                AnalyticSquare(title: "Interviewing", count: 0)
                AnalyticSquare(title: "Offers", count: 0)
            }
            .padding(.horizontal, 6)
            .fixedSize(horizontal: false, vertical: true)
            
            // add application section
            VStack(spacing: 24){
                Circle()
                    .foregroundStyle(.quinary)
                    .frame(width: 75, height: 75)
                
                Text("No applications yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Paste a job link from LinkedIn, Indeed, or Handshake to start tracking your search")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
                
                CButton(text: "Add application", buttonType: .black, leadingImage: Image(systemName: "plus")){
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, style: StrokeStyle(lineWidth: 1, dash: [10]))
            )
            .padding(.horizontal, 6)
            
            
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    DashboardEmpty()
}
