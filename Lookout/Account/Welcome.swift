//
//  Welcome.swift
//  Lookout
//
//  Created by Ethan Present on 10/2/26.
//

import SwiftUI

struct Welcome: View {
    
    @State var getStartedClick = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8){
                Spacer()
                
                Image("Lookout_logo")
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black)
                    )
                
                Text("Lookout")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Every application, one place.\nNever miss a next step.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                
                CButton(text: "Get started", buttonType: .black, fullWidth: true, cornerRadius: 8) {
                    getStartedClick.toggle()
                }
                .navigationDestination(isPresented: $getStartedClick) {
                    DashboardEmpty()
                }
                
                HStack(spacing: 5){
                    Text("Already have an account?")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Button("Log in"){
                        
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
                
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    Welcome()
}
