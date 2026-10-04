//
//  Notifications.swift
//  Lookout
//
//  Created by Brett Sestak on 10/4/26.
//

import SwiftUI

struct Notifications: View {
    var body: some View {
        VStack {
            Image(.turnOnNotifications)
                .resizable()
                .frame(width: 350, height: 225)
            Text("Never miss a next step")
                .font(.system(size: 35))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("Get a heads-up before online assessments, interviews, and follow-ups are due.")
                .font(.callout)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
            CButton(text: "Turn on notifications", buttonType: .black, fullWidth: true, cornerRadius: 8){}
                .padding()
            Text("Not now")
                
        }
    }
}

#Preview {
    Notifications()
}
