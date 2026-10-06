//
//  NoNotifs.swift
//  Lookout
//
//  Created by Brett Sestak on 10/6/26.
//

import SwiftUI

struct NoNotifs: View {

    var vm = ViewModel.shared

    var body: some View {
        VStack {
            PageBar(currentPage: 3, totalPages: 4, showBack: true) {
                vm.pop()
            }
                .padding()
            HStack {
                RoundedRectangle(cornerRadius: 50, style: .circular)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding()
            Text("Notifications are off")
                .font(.system(size: 35))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("You can still track everything in Lookout, but we won't be able to alert you before deadlines, assessments, and interviews.")
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Spacer().frame(height: 40)
            VStack {
                Text("Changed your mind?")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Turn them on anytime in Settings › Lookout › Notifications.")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 50)
            Spacer()
            CButton(text: "Open Settings", buttonType: .black, fullWidth: true, cornerRadius: 8){
                vm.push(.firstApplication)
            }
                .padding()
            Button("Continue without") {
                vm.push(.firstApplication)
            }
            .foregroundStyle(.black)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NoNotifs()
}
