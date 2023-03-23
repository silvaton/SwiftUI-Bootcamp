//
//  BackgroundAndOverlayBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 23/3/23.
//

import SwiftUI

struct BackgroundAndOverlayBootcamp: View {
    var matchCounts = 20
    
    var body: some View {
        let shadowLiteral = #colorLiteral(red: 0.814101398, green: 0.6059806943, blue: 0.2828401327, alpha: 0.5034147351)
        Image(systemName: "heart.fill")
            .font(.system(size: 40))
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
                    .frame(width: 100, height: 100)
                    .shadow(color: Color(shadowLiteral), radius: 10, x: 0.0, y: 10)
                    .overlay(
                        alignment: .topTrailing,
                        content: {
                        Circle()
                                .fill(.yellow)
                            .frame(width: 35, height: 35)
                            .overlay {
                                Text("\(matchCounts)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .shadow(color: Color(shadowLiteral), radius: 10, x: 5, y: 5)
                    })
            )

// Example 3:
//        Rectangle()
//            .frame(width: 100, height: 100)
//            .overlay(
//                Rectangle()
//                    .fill(Color.blue)
//                    .frame(width: 50, height: 50)
//                , alignment: .topLeading
//            )
//            .background(
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 150, height: 150)
//                ,alignment: .bottomTrailing
//            )
        
//Example 2:
//        Circle()
//            .fill(Color.pink)
//            .frame(width: 100, height: 100)
//            .overlay {
//                Text("1")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//            }
//            .background(
//                Circle()
//                    .fill(Color.purple)
//                    .frame(width: 110, height: 110)
//            )

// Example 1:
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .background(
//                //Color.red
//                //LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
//                Circle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
//                    .frame(width: 100, height: 100)
//            )
//            .background(
//                Circle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing))
//                    .frame(width: 120, height: 120)
//            )
    }
}

struct BackgroundAndOverlayBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAndOverlayBootcamp()
    }
}


// MARK: - Notes

// background: puts thing on behind of each other
// overlay: puts things on top of each other
