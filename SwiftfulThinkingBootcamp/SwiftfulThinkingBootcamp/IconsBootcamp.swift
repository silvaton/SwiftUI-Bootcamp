//
//  IconsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 21/3/23.
//

import SwiftUI

struct IconsBootcamp: View {
    var body: some View {
        Image(systemName: "mic.badge.xmark")
            .renderingMode(.original)
            //.resizable()
            //.aspectRatio(contentMode: .fit)
            //.scaledToFit()
            //.scaledToFill()
            .font(.largeTitle)
            //.font(.system(size: 200))
            //.foregroundColor(.red)
            //.frame(width: 300, height: 300)
            //.clipped()
    }
}

struct IconsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IconsBootcamp()
    }
}

// checkout the https://developer.apple.com/design/resources/#sf-symbols to download the app SF Symbols
//  with all icons available on swiftui.
