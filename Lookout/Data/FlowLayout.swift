//
//  FlowLayout.swift
//  Lookout
//
import SwiftUI
/// custom container that places items horizontally like an hstack
/// but auto wraps content that exceeds the width of the container
struct FlowLayout: Layout {
    var horizontalSpacing: CGFloat = 8
    var verticalSpacing: CGFloat = 8
    
    // tells the parent container how much space FlowLayout needs
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        var totalWidth: CGFloat = 0
        
        for subview in subviews{
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX > 0 && currentX + size.width > maxWidth{
                currentX = 0
                currentY += rowHeight + verticalSpacing
                rowHeight = 0
            }
            
            currentX += size.width
            totalWidth = max(totalWidth, currentX)
            rowHeight = max(rowHeight, size.height)
            currentX += horizontalSpacing
        }
        return CGSize(
            width: proposal.width ?? totalWidth,
            height: currentY + rowHeight
        )
    }
    
    // Once size is determined, SwiftUI calls this method to actually position each item on the screen
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX = bounds.minX
        var currentY = bounds.minY
        var rowheight: CGFloat = 0
        
        for subview in subviews{
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX > bounds.minX && currentX + size.width > bounds.maxX{
                
                currentX = bounds.minX
                currentY += rowheight + verticalSpacing
                rowheight = 0
            }
            
            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                anchor: .topLeading,
                proposal: ProposedViewSize(size))
            
            currentX += size.width + horizontalSpacing
            rowheight = max(rowheight, size.height)
        }
    }
}

#Preview {
    let items = ["one", "two", "long text", "three", "four", "longer text...", "five", "0", "six", "seven", "eight", "nine", "ten"]
    
    FlowLayout(horizontalSpacing: 16, verticalSpacing: 12){
        ForEach(items, id: \.self){ item in
            Text(item)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.gray.opacity(0.2))
                .clipShape(Capsule())
        }
    }
    .frame(width: 250)
    .border(.black)
}
