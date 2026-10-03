//
//  CButton.swift
//  Lookout
//
//  Created by Ethan Present on 9/28/26.
//

import SwiftUI

enum CButtonType{
    case black, white
}

struct CButton: View {
    
    let text: String
    let buttonType: CButtonType
    var fullWidth: Bool = false
    var cornerRadius: CGFloat = 12
    var leadingImage: Image? = nil
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
//    .border(.blue)
    
}
