//
//  Chip.swift
//  Lookout
//
import SwiftUI

/// The style of chip
enum ChipType {
    /// black background, white text
    case black
    /// white background, black text, gray border
    case white
    /// white background, black text, gray dashed border
    case bordered
    /// gray background, black text
    case gray
    /// gray background, red text
    case gray_red
}

/// Capsule-shaped component with text. Can be clickable
struct Chip: View {
    let text: String
    /// Style of the Chip: black, white, bordered, gray, gray_red
    let chipType: ChipType
    var horizontalPadding: CGFloat = 16
    var verticalPadding: CGFloat = 8
    /// optional leading image
    var leadingImage: Image? = nil
    /// Optional action for button chips
    var buttonAction: (() -> Void)? = nil

    // view builder lets you return multiple types of views
    // computed property generates pill background based on type
    @ViewBuilder
    private var chipBackground: some View {
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
        case .gray, .gray_red:
            Capsule()
                .fill(.quinary)
        }
    }
    
    private var textColor: Color {
        switch chipType {
        case .black:
            return .white
        case .gray_red:
            return .red
        default:
            return .black
        }
    }

    var body: some View {
        Group {
            if let buttonAction = buttonAction {
                Button {
                    buttonAction()
                } label: {
                    chipContent
                }
            } else {
                chipContent
            }
        }
    }

    private var chipContent: some View {
        Label {
            Text(text)
        } icon: {
            if let leadingImage = leadingImage {
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
        Chip(text: "Software Engineer", chipType: .gray)
        Chip(text: "Software Engineer", chipType: .gray_red)
    }
}
