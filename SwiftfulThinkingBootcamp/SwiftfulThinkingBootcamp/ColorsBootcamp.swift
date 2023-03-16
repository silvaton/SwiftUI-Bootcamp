//
//  ColorsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 16/3/23.
//

import SwiftUI

struct ColorsBootcamp: View {
    //var color = #colorLiteral(
    var color = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(
//                Color.primary
//                Color(color)
//                Color(uiColor: .secondarySystemBackground)
                Color("CustomColor")
            )
            .frame(width: 300, height: 200)
//            .shadow(radius: 10)
            .shadow(color: Color("CustomColor").opacity(0.3), radius: 10, x: -20, y: -20 )
    }
}

struct ColorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ColorsBootcamp()
    }
}
