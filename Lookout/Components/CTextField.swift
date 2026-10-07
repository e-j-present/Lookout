//
//  CTextField.swift
//  Lookout
//
import SwiftUI

/// Type of content the text field contains.
/// Sets the digital keyboard and provide auto-fill suggests based on this type
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

/// Main text field used throughout the app
struct CTextField: View {
    /// Text displayed above the text field
    var label: String
    var placeholder: String
    /// value of the text field
    @Binding var text: String
    /// type of the input. Look at `CTextFieldInputType`
    let inputType: CTextFieldInputType
    /// text displayed below the ltext field
    var hint: String? = nil
    /// true to turn the hint message red, false to keep it gray
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
