//
//  SavedApplicationCard.swift
//  Lookout
//
//  Created by Ethan Present on 9/30/26.
//

import SwiftUI

enum SavedApplicationCardAction{
    case cardTapped
    case favoriteToggled(isFavorite: Bool)
}

/// Card used for applications throughout the dashboard.
/// Github Issue Link: https://github.com/e-j-present/Lookout/issues/19
struct SavedApplicationCard: View {
    /// The role that the user is applying to. This is the main title
    var role: String
    /// Company the user is applying to. Text goes to the left of `source` and below `role`
    var company: String
    /// source where the user found the application. Text goes to the right of `company` and below of `role`
    var source: String
    var reminder: String
    var tagText: String
    var tagStyle: ChipType = .gray
    @Binding var isFavorite: Bool
    let id: UUID = UUID()
    /// Optional: called on all clicks if defined. Click here to see how to use it
    /// The idea behind this is you will need to access the id differently when clicking it based on favorites or not
    /// ```swift
    ///  // how to use this property
    /// SavedApplicationCard(// params){ id, cardAction in
    /// switch cardAction{
    ///     case .cardTapped:
    ///     // do things when the card gets tapped
    ///     case .favoriteToggled(let isFavorite):
    ///     //do things when the favorite button gets tapped
    /// }
    /// }
    /// ```
    var getID: ((UUID, SavedApplicationCardAction) -> Void)? = nil
    
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                // MARK: Company Logo
                Text(company.first!.uppercased())
                    .padding()
                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 1)
                            .fill(.black)
                    )
                    .foregroundStyle(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                // MARK: role, company, position, tags
                VStack(){
                    Text(role)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .minimumScaleFactor(0.65)
                        .lineLimit(1)
                    HStack{
                        Text(company)
                        Text("·")
                        Text(source)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    HStack{
                        Chip(text: tagText, chipType: tagStyle, horizontalPadding: 8, verticalPadding: 5)
                            .font(.subheadline)
                            .minimumScaleFactor(0.6)
                            .lineLimit(1)
                        Text(reminder)
                            .font(.subheadline)
                            .foregroundStyle(tagStyle == .gray_red ? .red : .secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.70, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .top)
//                .border(.blue)
                
                // MARK: favorites
                Button{
                    isFavorite.toggle()
                    if let getID = getID {
                        getID(id, .favoriteToggled(isFavorite: isFavorite))
                    }
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.title2)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .tint(.black)
                .buttonStyle(.borderless)
//                .border(.green)
            }
            .frame(maxHeight: .infinity, alignment: .top)
//            .border(.orange)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        )
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .contentShape(Rectangle())
        .onTapGesture {
            if let getID = getID {
                getID(id, .cardTapped)
            }
        }
    }
}

#Preview {
    @Previewable @State var isFavorite1 = false
    @Previewable @State var isFavorite2 = true
    
    VStack {
        SavedApplicationCard(role: "Data Analyst, New Grad", company: "Capital One", source: "Handshake", reminder: "Thu, 2:00 PM", tagText: "Online Assessment", isFavorite: $isFavorite1)
        
        SavedApplicationCard(role: "Data Analyst, New Grad", company: "Amazon", source: "Handshake", reminder: "Tue, Oct 21", tagText: "Long Tag Text. ABC DEF GHI JK", isFavorite: $isFavorite2)
        
        SavedApplicationCard(role: "Longer Title to Test the title truncation", company: "Google", source: "Handshake", reminder: "Due tomorrow", tagText: "Long Tag Text. ABC DEF GHI JK", tagStyle: .gray_red, isFavorite: $isFavorite2) { id, cardAction in
            switch cardAction{
            case .cardTapped:
                print("the card was tapped: \(id)")
            case .favoriteToggled(let isFav):
                print("is fav: \(isFav)")
            }
        }
    }
}
