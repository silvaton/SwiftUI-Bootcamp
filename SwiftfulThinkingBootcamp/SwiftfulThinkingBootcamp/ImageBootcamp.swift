//
//  ImageBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 22/3/23.
//

import SwiftUI

struct ImageBootcamp: View {
    var body: some View {
        Image("google")
            .resizable()
//            .renderingMode(.template)
//            .aspectRatio(contentMode: .fit)
            .scaledToFit()
//            .scaledToFill()
            .frame(width: 300, height: 200)
            .foregroundColor(.cyan)
//            .clipped()
//            .cornerRadius(150)
            //.clipShape(
//                Circle()
//                RoundedRectangle(cornerRadius: 25.0)
//                Ellipse()
                //Circle()
            //)
        
    }
}

struct ImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ImageBootcamp()
    }
}
