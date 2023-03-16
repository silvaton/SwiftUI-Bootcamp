//
//  ShapesBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 16/3/23.
//

import SwiftUI

struct ShapesBootcamp: View {
    var body: some View {
//        Circle()
//        Ellipse()
//        Capsule(style: .circular)
//        Rectangle()
        RoundedRectangle(cornerRadius: 10)
//            .fill(Color.brown)
//            .foregroundColor(.green)
//            .stroke()
//            .stroke(Color.cyan)
//            .stroke(Color.brown, lineWidth: 30)
//            .stroke(.orange, style: StrokeStyle(lineWidth: 30, lineCap: .round, dash: [30]))
//            .trim(from: 0.5, to: 1.0)
//            .stroke(.purple, lineWidth: 50)
        
            // for ellipse
            .frame(width: 300, height: 200)
    }
}

struct ShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ShapesBootcamp()
    }
}
