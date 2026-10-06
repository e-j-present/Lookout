//
//  CreateAccount.swift
//  Lookout
//
//  Created by Ethan Present on 10/3/26.
//

import SwiftUI

enum PasswordStrength: Int {
    case weak = 1
    case medium = 2
    case strong = 3
    case excellent = 4

    var label: String {
        switch self {
        case .weak: return "Weak"
        case .medium: return "Medium"
        case .strong: return "Strong"
        case .excellent: return "Excellent"
        }
    }
    
    var color: Color {
        switch self{
        case .weak:
            return .red
        case .medium:
            return .yellow
        case .strong:
            return .green.opacity(0.5)
        case .excellent:
            return .green
        }
    }
}

struct CreateAccount: View {

    var vm = ViewModel.shared

    @State var firstName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showErrorMessage: Bool = false
    @State var errorTitle: String = "Couldn't Connect"
    @State var errorMessage: String = "Check your connection and try again. Your info is still here."

    
    let passwordOriginalHintMessage: String = "Use 8+ characters with a number or symbol"
    @State var passwordHintMessage: String = "Use 8+ characters with a number or symbol"
    @State var passwordShowErrorMessage: Bool = false

    var passwordStrength: PasswordStrength {
        switch password.count {
        case 0...4:
            return .weak
        case 5...7:
            return .medium
        case 8...11:
            return .strong
        default:
            return .excellent
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            VStack(alignment: .leading){
                Text("Create your account")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Track every application and get a heads-up before anything's due.")
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quinary)
                )
            }
            
            CTextField(label: "First Name", placeholder: "First name", text: $firstName, inputType: .firstName)
            CTextField(label: "Email", placeholder: "you@school.edu", text: $email, inputType: .email)
            CTextField(label: "Password", placeholder: "Create a password", text: $password, inputType: .password, hint: passwordHintMessage, showErrorMessage: passwordShowErrorMessage)

            if !password.isEmpty{
                HStack{
                    ForEach(1..<5){ index in
                        Capsule()
                            .foregroundStyle(index <= passwordStrength.rawValue ? .black : .secondary)
                            .frame(height: 5)
                    }

                    Text(passwordStrength.label)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(passwordStrength.color)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            
            CButton(text: "Create account", buttonType: .black, fullWidth: true) {

                vm.createAccount(firstName: firstName, email: email, password: password, passwordStrength: passwordStrength) { code in
                    if case .emptyAccountInfo(let emptyAccountInfo) = code {
                        print(emptyAccountInfo)
                        withAnimation {
                            switch emptyAccountInfo{
                            case .name:
                                errorTitle = "Empy name"
                                errorMessage = "You must provide a name"
                                showErrorMessage = true
                            case .email:
                                errorTitle = "Empy email"
                                errorMessage = "You must provide an email address"
                                showErrorMessage = true
                            case .password:
                                errorTitle = "Empy password"
                                errorMessage = "You must provide a password"
                                showErrorMessage = true
                            default:
                                showErrorMessage = false
                            }

                        }
                    }

                    if case .passwordInfo(let passwordInfo) = code {
                        switch passwordInfo{
                        case .weak:
                            withAnimation {
                                passwordHintMessage = "Too Weak"
                                passwordShowErrorMessage = true
                            }
                        default:
                            withAnimation {
                                passwordHintMessage = passwordOriginalHintMessage
                                passwordShowErrorMessage = false
                            }
                        }
                    }

                }

                // account created with no validation errors: start onboarding fresh, with no way back to account creation
                if !showErrorMessage && !passwordShowErrorMessage {
                    vm.setRoot(.roles)
                }

            }
            
            HStack {
                Spacer()
                Text("By continuing you agree to our Terms and Privacy policy.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            Spacer()
            
            HStack(spacing: 5){
                Spacer()
                
                Text("Already have an account?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Button("Log in"){
                    vm.replaceTop(with: .logIn)
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
    CreateAccount()
}
