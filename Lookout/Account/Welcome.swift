//
//  Welcome.swift
//  Lookout
//
//  Created by Ethan Present on 10/2/26.
//

import SwiftUI

struct Welcome: View {

    @Bindable var vm = ViewModel.shared

    var body: some View {
        NavigationStack(path: $vm.navigationPath) {
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
                    vm.go(to: .createAccount)
                }

                HStack(spacing: 5){
                    Text("Already have an account?")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Button("Log in"){
                        vm.go(to: .logIn)
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }


            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .createAccount:
                    CreateAccount()
                case .logIn:
                    LogIn()
                case .welcome:
                    Welcome()
                case .mainNavScreen:
                    MainNavScreen()
                case .addScreen:
                    AddScreen()
                }
            }
        }
    }
}

#Preview {
    Welcome()
}
