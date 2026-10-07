//
//  SavedApplicationCard.swift
//  Lookout
//
import SwiftUI

enum SavedApplicationCardAction{
    case cardTapped
    case favoriteToggled(isFavorite: Bool)
}

/// Card used for applications throughout the dashboard.
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
        HStack(spacing: 12) {
            // MARK: - Company Logo
            Text(company.first?.uppercased() ?? "?")
                .frame(width: 60, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.black)
                )
                .foregroundStyle(.white)
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxHeight: .infinity, alignment: .top)

            // MARK: - Main content
            VStack(alignment: .leading) {
                Text(role)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.65)
                    .lineLimit(1)

                HStack {
                    Text(company)
                    Text("·")
                    Text(source)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Spacer()

                HStack {
                    Chip(
                        text: tagText,
                        chipType: tagStyle,
                        horizontalPadding: 8,
                        verticalPadding: 5
                    )
                    .font(.subheadline)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)

                    Text(reminder)
                        .font(.subheadline)
                        .foregroundStyle(
                            tagStyle == .gray_red ? .red : .secondary
                        )
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // MARK: - Favorite
            Button {
                isFavorite.toggle()
                getID?(id, .favoriteToggled(isFavorite: isFavorite))
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .font(.title2)
            }
            .tint(.black)
            .buttonStyle(.borderless)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        )
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
