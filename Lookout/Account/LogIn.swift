//
//  LogIn.swift
//  Lookout
//
//  Created by Ethan Present on 10/4/26.
//

import SwiftUI

struct LogIn: View {

    var vm = ViewModel.shared

    @State var firstName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showErrorMessage: Bool = false
    @State var errorTitle: String = "Couldn't Connect"
    @State var errorMessage: String = "Check your connection and try again. Your info is still here."
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            VStack(alignment: .leading){
                Text("Welcome back")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Log in to pick up where you left off")
                    .foregroundStyle(.secondary)
            }
            
            if showErrorMessage{
                VStack(alignment: .leading){
                    Text(errorTitle)
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                    
                    Text(errorMessage)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quinary)
                )
            }
            
            CTextField(label: "Email", placeholder: "you@school.edu", text: $email, inputType: .email)
            CTextField(label: "Password", placeholder: "Create a password", text: $password, inputType: .password)

            HStack{
                Spacer()
                
                Button{
                    
                } label: {
                    Text("Forgot Password")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
            }
            
            CButton(text: "Log in", buttonType: .black, fullWidth: true) {
                let LoginResults = vm.login(email: email, password: password)
                
                if LoginResults{
                    print("Succesfully Singed in")
                    withAnimation {
                        showErrorMessage = false
                    }
                } else{
                    print("Error")
                    
                    withAnimation {
                        errorTitle = "Incorrect email or password"
                        errorMessage = "The email or password your provided was incorrect. Try again"
                        showErrorMessage = true
                    }
                }
                
            }
            
            Spacer()
            
            HStack(spacing: 5){
                Spacer()
                
                Text("New to Lookout?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Button("Create an Account"){
                    vm.go(to: .createAccount)
                }
                .foregroundStyle(.black)
                .font(.subheadline)
                .fontWeight(.semibold)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    LogIn()
}
