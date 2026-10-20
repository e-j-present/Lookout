//
//  Welcome.swift
//  Lookout
//
//
import SwiftUI

struct Welcome: View {

    let vm = ViewModel.shared

    var body: some View {
        VStack(spacing: 8){
            Spacer()

            Image("Lookout_logo")
                .foregroundStyle(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.black)
                )
            //TODO: Remove this later. This is here so I don't have to log in each time to test the app
                .onTapGesture {
                    vm.setRoot(.mainNavScreen)
                }

            Text("Lookout")
                .font(.title)
                .fontWeight(.semibold)

            Text("Every application, one place.\nNever miss a next step.")
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Spacer()

            CButton(text: "Get started", buttonType: .black, fullWidth: true, cornerRadius: 8) {
                vm.push(.createAccount)
            }

            HStack(spacing: 5){
                Text("Already have an account?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Button("Log in"){
                    vm.push(.logIn)
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

#Preview {
    Welcome()
}
