//
//  ReminderDetails.swift
//  Lookout
//
import SwiftUI

// MARK: - Reminder Item

struct ReminderItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

// MARK: - Reminder Details

struct ReminderDetails: View {
    let reminders: [ReminderItem]

    // MARK: - Callbacks

    var onAdd: (() -> Void)? = nil
    var onReminderTap: ((ReminderItem) -> Void)? = nil

    // MARK: - Customization

    var primaryColor: Color = .primary
    var secondaryColor: Color = .secondary
    var circleColor: Color = .gray.opacity(0.1)
    var dividerColor: Color = .gray.opacity(0.3)

    var circleDiameter: CGFloat = 44
    var rowSpacing: CGFloat = 12
    var rowPadding: CGFloat = 12
    var headerSpacing: CGFloat = 4
    var textSpacing: CGFloat = 4

    var headerFont: Font = .title3
    var titleFont: Font = .headline
    var subtitleFont: Font = .subheadline

    var body: some View {
        VStack(alignment: .leading, spacing: headerSpacing) {
            header

            VStack(spacing: 0) {
                ForEach(reminders) { reminder in
                    reminderRow(reminder)

                    if reminder.id != reminders.last?.id {
                        Divider()
                            .overlay(dividerColor)
                    }
                }
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Text("Reminders")
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

    // MARK: - Reminder Row

    @ViewBuilder
    private func reminderRow(
        _ reminder: ReminderItem
    ) -> some View {
        if let onReminderTap {
            Button {
                onReminderTap(reminder)
            } label: {
                rowContent(reminder)
            }
            .buttonStyle(.plain)
        } else {
            rowContent(reminder)
        }
    }

    // MARK: - Row Content

    private func rowContent(
        _ reminder: ReminderItem
    ) -> some View {
        HStack(spacing: rowSpacing) {
            Circle()
                .fill(circleColor)
                .frame(
                    width: circleDiameter,
                    height: circleDiameter
                )
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: textSpacing) {
                Text(reminder.title)
                    .font(titleFont)
                    .fontWeight(.semibold)
                    .foregroundStyle(primaryColor)

                Text(reminder.subtitle)
                    .font(subtitleFont)
                    .foregroundStyle(secondaryColor)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(secondaryColor)
                .accessibilityHidden(true)
        }
        .padding(.vertical, rowPadding)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ReminderDetails(reminders: [
        .init(title: "One", subtitle: "one"),
        .init(title: "Two", subtitle: "two")
    ])
}
