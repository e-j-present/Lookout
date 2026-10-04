//
//  CTextField.swift
//  Lookout
//
//  Created by Ethan Present on 10/3/26.
//

import SwiftUI

enum CTextFieldInputType{
    case email
    case password
    case url
    case fullName
    case firstName
    case lastName
    case genericText
    
    var keyboardType: UIKeyboardType {
        switch self{
        case .email:
            return .emailAddress
        case .url:
            return .URL
        default:
            return .default
        }
    }
    
    var textContentType: UITextContentType? {
        switch self{
        case .email:
            return .emailAddress
        case .password:
            return .password
        case .url:
            return .URL
        case .fullName:
            return .name
        case .firstName:
            return .givenName
        case .lastName:
            return .familyName
        default:
            return nil
        }
    }
    
}

struct CTextField: View {
    
    var label: String
    var placeholder: String
    @Binding var text: String
    let inputType: CTextFieldInputType
    var hint: String? = nil
    var showErrorMessage: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(label)
            
            ZStack {
                TextField(text: $text) {
                    Text(placeholder)
                }
                .opacity(inputType == .password ? 0.0 : 1.0)
                
                SecureField(text: $text) {
                    Text(placeholder)
                }
                .opacity(inputType == .password ? 1.0 : 0.0)
            }
            .padding()
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.tertiary, lineWidth: 1)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(inputType.keyboardType)
            .textContentType(inputType.textContentType)
            
            if let hint {
                Text(hint)
                    .foregroundColor(showErrorMessage ? .red : .secondary)
            }
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    CTextField(label: "First name", placeholder: "First name", text: $text, inputType: .password, hint: "Enter your first name", showErrorMessage: false)
        .padding(.horizontal)
}
