//
//  CButton.swift
//  Lookout
//
import SwiftUI

/// Button Style
enum CButtonType{
    /// black background, white text
    case black
    /// white background , black text, black border
    case white
}
/// Main button style used throughout the app
struct CButton: View {
    let text: String
    /// Style of button. Look at `CButtonType`
    let buttonType: CButtonType
    /// True to make the button's width the full width of the parent container. False to take the width of the content
    var fullWidth: Bool = false
    /// corner raidus of the buttons background shape
    var cornerRadius: CGFloat = 12
    /// optional leading image for the button
    var leadingImage: Image? = nil
    /// button action
    let action: () -> Void
    
    private var backgroundColor: Color {
        switch buttonType {
        case .black:
            return .black
        case .white:
            return .white
        }
    }
    private var foregroundColor: Color {
        switch buttonType {
        case .black:
            return .white
        case .white:
            return .black
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Label {
                Text(text)
            } icon: {
                if let leadingImage = leadingImage {
                    leadingImage
                }
            }
            .fontWeight(buttonType == .black ? .semibold : .regular)
            .frame(maxWidth: fullWidth ? .infinity: nil)
            .padding(16)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.black, lineWidth: buttonType == .white ? 1 : 0)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack{
        CButton(text: "Button", buttonType: .white){}
        CButton(text: "Button", buttonType: .black){}
        CButton(text: "Long Button text", buttonType: .white){}
        CButton(text: "Long Button text", buttonType: .black, leadingImage: Image(systemName: "plus")){}
        CButton(text: "Long Button text", buttonType: .white, fullWidth: true, cornerRadius: 8){}
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity)
}
