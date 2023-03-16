//
//  GradientsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 16/3/23.
//

import SwiftUI

struct GradientsBootcamp: View {

    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(
//                .red
//                LinearGradient(
//                    gradient: Gradient(colors: [Color(uiColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)), Color(uiColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]),
//                    startPoint: .top,
//                    endPoint: .bottom)
//                RadialGradient(
//                    gradient: Gradient(colors: [Color(uiColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)), Color(uiColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]),
//                    center: .leading,
//                    startRadius: 5,
//                    endRadius: 400)
                AngularGradient(
                    gradient: Gradient(colors: [Color(uiColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)), Color(uiColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]),
                    center: .topLeading,
                    angle: .degrees(180 + 45))
            )
            .frame(width: 300, height: 200)
    }
}

struct GradientsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GradientsBootcamp()
    }
}
