//
//  PieChartView.swift
//  Lesson 6
//
//  Created by Alexey Sobolevsky on 20/06/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import UIKit

struct Segment: Equatable {
    let color: UIColor
    var value: CGFloat
    var title: String
    
    static func == (lhs: Segment, rhs: Segment) -> Bool {
        return lhs.color == rhs.color && lhs.value == rhs.value && lhs.title == rhs.title
    }
}

@IBDesignable
class PieChartView: UIView {

    var segments: [Segment] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        setNeedsDisplay()
    }

    func setup(segmentArr: [Segment]? = nil) {
        isOpaque = false // если переписывам drawRect нужно явно выставить прозрачность
        if let array = segmentArr, !array.isEmpty {
            segments = array
        } else {
            segments = [
                Segment(color: .red, value: 57, title: "Red"),
                Segment(color: .blue, value: 30, title: "Blue"),
                Segment(color: .green, value: 25, title: "Green"),
                Segment(color: .yellow, value: 40, title: "Yellow")
            ]
        }
    }

    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .font               : UIFont.systemFont(ofSize: 14),
        .foregroundColor    : UIColor.black
    ]

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let radius = min(frame.width, frame.height) * 0.5
        let textPositionOffset: CGFloat = 0.67
        let viewCenter = bounds.center
        let totalSegmentsValue = segments.reduce(0, { $0 + $1.value })
        var startAngle = -CGFloat.pi * 0.5

        for segment in segments {
            context.setFillColor(segment.color.cgColor)

            // Draw a slice
            let endAngle = startAngle + 2 * .pi * (segment.value / totalSegmentsValue)
            context.move(to: viewCenter)
            context.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.fillPath()

            // Draw a delimiter
            context.move(to: viewCenter)
            context.addLine(to: CGPoint(center: viewCenter, radius: radius, degrees: endAngle))
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(2)
            context.strokePath()

            // Draw a label
            
            let halfAngle = startAngle + (endAngle - startAngle) * 0.5
            let segmentCenter = viewCenter.projected(by: radius * textPositionOffset, angle: halfAngle)
            let textToRender = segment.title as NSString
            let renderRect =  CGRect(centeredOn: segmentCenter, size: textToRender.size(withAttributes: textAttributes))
            textToRender.draw(in: renderRect, withAttributes: textAttributes)

            startAngle = endAngle
        }
    }
    
    func addTitleToSegment(title: String, seg: Segment) {
        
        guard let segmentIndex = self.segments.firstIndex(where: {return seg == $0}) else { return }
        
        self.segments[segmentIndex].title = title
        let radius = min(frame.width, frame.height) * 0.5
        let textPositionOffset: CGFloat = 0.67
        let viewCenter = bounds.center
        let totalSegmentsValue = segments.reduce(0, { $0 + $1.value })
        var startAngle = -CGFloat.pi * 0.5
        
        for segment in segments {
            let endAngle = startAngle + 2 * .pi * (segment.value / totalSegmentsValue)
            if segment == seg {
                let halfAngle = startAngle + (endAngle - startAngle) * 0.5
                let segmentCenter = viewCenter.projected(by: radius * textPositionOffset, angle: halfAngle)
                let textToRender = segment.title as NSString
                let renderRect =  CGRect(centeredOn: segmentCenter, size: textToRender.size(withAttributes: textAttributes))
                textToRender.draw(in: renderRect, withAttributes: textAttributes)
            }
            startAngle = endAngle
        }
    
    }
    

}

extension CGFloat {
    var radiansToDegrees: CGFloat {
        return self * 180 / .pi
    }
}

extension CGPoint {
    init(center: CGPoint, radius: CGFloat, degrees: CGFloat) {
        self.init(x: cos(degrees) * radius + center.x,
                  y: sin(degrees) * radius + center.y)
    }

    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(
            x: x + value * cos(angle), y: y + value * sin(angle)
        )
    }
}

extension CGRect {
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(
                x: center.x - size.width * 0.5, y: center.y - size.height * 0.5
            ),
            size: size
        )
    }
    var center: CGPoint {
        return CGPoint(x: width / 2 + origin.x,
                       y: height / 2 + origin.y)
    }
}
