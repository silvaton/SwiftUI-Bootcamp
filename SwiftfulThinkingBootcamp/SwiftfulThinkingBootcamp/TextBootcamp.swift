//
//  TextBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 7/3/23.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("Hello, World! this is the Swiftful Thinking Bootcamp. I am really enjoying this course and learning alot.".capitalized)
            //.font(.body)
//            .fontWeight(.semibold)
            //.bold()
            //.underline()
            //.underline(true, color: .red)
            //.italic()
            //.strikethrough()
            //.strikethrough(true, color: .green)
            //.font(.system(size: 24, weight: .semibold, design: .serif))
            //.baselineOffset(10.0)
            //.kerning(4)
            .multilineTextAlignment(.leading)
            .foregroundColor(.blue)
            .frame(width: 200, height: 100, alignment: .leading)
            .minimumScaleFactor(0.1)
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
