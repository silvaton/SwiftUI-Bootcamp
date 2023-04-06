//
//  AnimationsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 6/4/23.
//

import SwiftUI

struct AnimationsBootcamp: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        VStack {
            Button("Button") {
                withAnimation(
                    Animation
                        .default
                        .repeatForever(autoreverses: true)) {
                    isAnimated.toggle()
                }
            }
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100: 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300 : 0)

            Spacer()
        }
    }
    
   // Example 4:
    
//    var body: some View {
//        VStack {
//            Button("Button") {
//                isAnimated.toggle()
//            }
//            Spacer()
//            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
//                .fill(isAnimated ? Color.red : Color.green)
//                .frame(
//                    width: isAnimated ? 100 : 300,
//                    height: isAnimated ? 100: 300)
//                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
//                .offset(y: isAnimated ? 300 : 0)
//                .animation(Animation
//                    .default
//                    .repeatForever(autoreverses: true))
//            Spacer()
//        }
//    }
    
    //Example 3:
//    var body: some View {
//        VStack {
//            Button("Button") {
//                withAnimation(
//                    Animation
//                        .default
//                        .repeatCount(5, autoreverses: false)) {
//                    isAnimated.toggle()
//                }
//            }
//            Spacer()
//            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
//                .fill(isAnimated ? Color.red : Color.green)
//                .frame(
//                    width: isAnimated ? 100 : 300,
//                    height: isAnimated ? 100: 300)
//                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
//                .offset(y: isAnimated ? 300 : 0)
//
//
//
//            Spacer()
//        }
//    }
    
    // Example 2:
//    var body: some View {
//        VStack {
//            Button("Button") {
//                withAnimation(Animation.default.delay(2.0)) {
//                    isAnimated.toggle()
//                }
//            }
//            Spacer()
//            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
//                .fill(isAnimated ? Color.red : Color.green)
//                .frame(
//                    width: isAnimated ? 100 : 300,
//                    height: isAnimated ? 100: 300)
//                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
//                .offset(y: isAnimated ? 300 : 0)
//
//            Spacer()
//        }
//    }
    
    // Example 1:
//    var body: some View {
//        VStack {
//            Button("Button") {
//                withAnimation(.default) {
//                    isAnimated.toggle()
//                }
//            }
//            Spacer()
//            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
//                .fill(isAnimated ? Color.red : Color.green)
//                .frame(
//                    width: isAnimated ? 100 : 300,
//                    height: isAnimated ? 100: 300)
//                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
//                .offset(y: isAnimated ? 300 : 0)
////                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0)) (rotation should not be here)
//
//
//
//            Spacer()
//        }
//    }
}

struct AnimationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsBootcamp()
    }
}
