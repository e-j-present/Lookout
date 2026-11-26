//
//  NotesCard.swift
//  Lookout
//
import SwiftUI

// MARK: - Note Item

struct NoteItem: Identifiable {
    var id: UUID = UUID()
    let tag: String
    let date: String
    let notes: String
}

// MARK: - Notes Card

struct NotesCard: View {
    let notes: [NoteItem]

    // MARK: - Callbacks

    var onAdd: (() -> Void)? = nil
    var onNoteTap: ((NoteItem) -> Void)? = nil

    // MARK: - Customization

    var primaryColor: Color = .primary
    var secondaryColor: Color = .secondary

    var noteLineLimit: Int? = nil

    var headerSpacing: CGFloat = 20
    var noteSpacing: CGFloat = 24
    var metadataSpacing: CGFloat = 8
    var contentSpacing: CGFloat = 8
    var noteHorizontalPadding: CGFloat = 8

    var headerFont: Font = .title3
    var tagFont: Font = .subheadline
    var dateFont: Font = .subheadline
    var noteFont: Font = .body

    var body: some View {
        VStack(alignment: .leading, spacing: headerSpacing) {
            header

            VStack(alignment: .leading, spacing: noteSpacing) {
                ForEach(notes) { note in
                    noteRow(note)
                }
            }
            .padding(.horizontal, noteHorizontalPadding)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Text("Notes")
                .font(headerFont)
                .fontWeight(.semibold)

            Spacer()

            Button {
                onAdd?()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                    Text("Add")
                }
                .font(.headline)
            }
            .buttonStyle(.plain)
            .disabled(onAdd == nil)
        }
        .foregroundStyle(primaryColor)
    }

    // MARK: - Note Row

    @ViewBuilder
    private func noteRow(_ note: NoteItem) -> some View {
        if let onNoteTap {
            Button {
                onNoteTap(note)
            } label: {
                noteContent(note)
            }
            .buttonStyle(.plain)
        } else {
            noteContent(note)
        }
    }

    // MARK: - Note Content

    private func noteContent(_ note: NoteItem) -> some View {
        VStack(alignment: .leading, spacing: contentSpacing) {
            HStack(spacing: metadataSpacing) {
                Chip(
                    text: note.tag,
                    chipType: .white,
                    horizontalPadding: 8,
                    verticalPadding: 4)
                    .font(tagFont)
                    .fontWeight(.semibold)

                Text(note.date)
                    .font(dateFont)
                    .foregroundStyle(secondaryColor)
            }

            Text(note.notes)
                .font(noteFont)
                .foregroundStyle(primaryColor)
                .multilineTextAlignment(.leading)
                .lineLimit(noteLineLimit)
                .truncationMode(.tail)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    NotesCard(notes: [
        .init(tag: "Referral", date: "Sep 27", notes: "reffered by Jordan")
    ])
}
