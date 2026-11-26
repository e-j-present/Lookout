//
//  ProgressTimeline.swift
//  Lookout
//
import SwiftUI

// MARK: - Timeline Step

struct TimelineStep {
    let title: String
    var alias: String? = nil

    var displayTitle: String {
        alias ?? title
    }
}

// MARK: - Timeline Step Status
enum TimelineStepStatus {
    case completed
    case current
    case upcoming
}

// MARK: - Progress Timeline
struct ProgressTimeline: View {
    let steps: [TimelineStep]
    let currentStep: Int

    var primaryColor: Color = .primary
    var secondaryColor: Color = .gray.opacity(0.4)

    var circleDiameter: CGFloat = 26
    var lineWidth: CGFloat = 2
    var circleBorderWidth: CGFloat = 2
    var minimumStepWidth: CGFloat = 60
    var labelSpacing: CGFloat = 8
    var labelFont: Font = .caption

    private var minimumWidth: CGFloat {
        CGFloat(steps.count) * minimumStepWidth
    }

    var body: some View {
        ViewThatFits(in: .horizontal) {
            timeline
                .frame(minWidth: minimumWidth)

            ScrollView(.horizontal, showsIndicators: false) {
                timeline
                    .frame(minWidth: minimumWidth)
            }
        }
    }

    // MARK: - Timeline Layout
    private var timeline: some View {
        VStack(spacing: labelSpacing) {
            indicators
            labels
        }
    }

    // MARK: - Indicators
    private var indicators: some View {
        HStack(spacing: 0) {
            ForEach(steps.indices, id: \.self) { index in
                stepIndicator(at: index)
                    .frame(maxWidth: .infinity)
                    .background {
                        connectingLines(at: index)
                    }
            }
        }
        .frame(height: circleDiameter)
    }

    // MARK: - Connecting Lines
    private func connectingLines(at index: Int) -> some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(
                    index == 0
                    ? Color.clear
                    : lineColor(at: index - 1)
                )
                .frame(height: lineWidth)

            Color.clear
                .frame(
                    width: circleDiameter,
                    height: lineWidth
                )

            Rectangle()
                .fill(
                    index == steps.count - 1
                    ? Color.clear
                    : lineColor(at: index)
                )
                .frame(height: lineWidth)
        }
    }

    private func lineColor(at index: Int) -> Color {
        index < currentStep
            ? primaryColor
            : secondaryColor
    }

    // MARK: - Labels
    private var labels: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(steps.indices, id: \.self) { index in
                Text(steps[index].displayTitle)
                    .font(labelFont)
                    .fontWeight(
                        index == currentStep
                        ? .semibold
                        : .regular
                    )
                    .foregroundStyle(
                        index <= currentStep
                        ? primaryColor
                        : secondaryColor
                    )
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 2)
                    .accessibilityLabel(
                        steps[index].title
                    )
                    .accessibilityValue(
                        accessibilityStatus(at: index)
                    )
            }
        }
    }

    // MARK: - Step Indicator
    private func stepIndicator(at index: Int) -> some View {
        TimelineStepIndicator(
            status: status(at: index),
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            diameter: circleDiameter,
            borderWidth: circleBorderWidth
        )
        .accessibilityHidden(true)
    }

    // MARK: - Step Status
    private func status(at index: Int) -> TimelineStepStatus {
        if index < currentStep {
            return .completed
        } else if index == currentStep {
            return .current
        } else {
            return .upcoming
        }
    }

    private func accessibilityStatus(at index: Int) -> String {
        switch status(at: index) {
        case .completed:
            return "Completed"
        case .current:
            return "Current step"
        case .upcoming:
            return "Upcoming"
        }
    }
}

// MARK: - Timeline Step Indicator
private struct TimelineStepIndicator: View {
    let status: TimelineStepStatus
    let primaryColor: Color
    let secondaryColor: Color

    let diameter: CGFloat
    let borderWidth: CGFloat

    var body: some View {
        ZStack {
            switch status {
            case .completed:
                Circle()
                    .fill(primaryColor)

                Image(systemName: "checkmark")
                    .font(
                        .system(
                            size: diameter * 0.4,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(.background)

            case .current:
                Circle()
                    .strokeBorder(
                        primaryColor,
                        lineWidth: borderWidth
                    )

                Circle()
                    .fill(primaryColor)
                    .frame(
                        width: diameter * 0.38,
                        height: diameter * 0.38
                    )

            case .upcoming:
                Circle()
                    .strokeBorder(
                        secondaryColor,
                        lineWidth: borderWidth
                    )
            }
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    ProgressTimeline(steps: [
        .init(title: "Saved"),
        .init(title: "Applied"),
        .init(title: "Online Assessment", alias: "OA"),
        .init(title: "Interview 1", alias: "Int. 1"),
        .init(title: "Interview 2", alias: "Int. 2"),
        .init(title: "Offer"),
        
    ], currentStep: 3)
}
