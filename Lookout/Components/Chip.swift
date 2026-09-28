//
//  Chip.swift
//  Lookout
//
//  Created by Ethan Present on 9/28/26.
//
import SwiftUI

// different types of Chips based on figma
enum ChipType{
    case black, white, bordered
}
struct Chip: View {
    let text: String
    let chipType: ChipType
    let horizontalPadding: CGFloat = 16
    let verticalPadding: CGFloat = 8
    var leadingImage: Image? = nil
    
    // view builder lets you return multiple types of views
    // computed property generates pill background based on type
    @ViewBuilder
    private var chipBackground: some View{
        switch chipType {
        case .black:
            Capsule()
                .fill(.black)
        case .white:
            Capsule()
                .fill(.white)
                .stroke(.gray, lineWidth: 1.0)
        case .bordered:
            Capsule()
                .fill(.white)
                .stroke(.gray, style: StrokeStyle(lineWidth: 1.5, dash: [10]))
        }
    }
   
    private var textColor: Color{
        switch (chipType){
        case .black:
            return .white
        default:
            return .black
        }
    }
    var body: some View {
        Label{
            Text(text)
        } icon: {
            if let leadingImage = leadingImage{
                leadingImage
            }
        }
            .foregroundStyle(textColor)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(chipBackground)
    }
}

#Preview {
    VStack(spacing: 30){
        Chip(text: "Really long string to test the pill. It will wrap to two lines", chipType: .bordered)
        Chip(text: "Product Manager", chipType: .black)
        Chip(text: "Software Engineer", chipType: .white)
        Chip(text: "Other", chipType: .bordered, leadingImage: Image(systemName: "plus"))
    }
}
