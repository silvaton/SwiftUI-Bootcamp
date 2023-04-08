//
//  TransitionBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 8/4/23.
//

import SwiftUI

struct TransitionBootcamp: View {
    
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {

            VStack {
                Button("Button") {
                    withAnimation {
                        showView.toggle()
                    }
                }
                Spacer()
            }
            if showView {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading),
                        removal: AnyTransition.opacity.animation(.easeOut)))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Example 5:
    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            VStack {
//                Button("Button") {
//                    showView.toggle()
//                }
//                Spacer()
//            }
//            if showView {
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(AnyTransition.scale.animation(.easeOut))
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
    
    // Example 4:
    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            VStack {
//                Button("Button") {
//                    showView.toggle()
//                }
//                Spacer()
//            }
//            if showView {
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(AnyTransition.opacity.animation(.easeOut))
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }

    // Example 3:
    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            VStack {
//                Button("Button") {
//                    withAnimation {
//                        showView.toggle()
//                    }
//                }
//                Spacer()
//            }
//            if showView {
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(.move(edge: .bottom))
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
    
    // Example 2:
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            VStack {
//                Button("Button") {
//                    withAnimation {
//                        showView.toggle()
//                    }
//                }
//                Spacer()
//            }
//            if showView {
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(.slide)
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }

    
    // Example 1: it's still animation to use when the object is already in the view
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            VStack {
//                Button("Button") {
//                    showView.toggle()
//                }
//                Spacer()
//            }
//
//            RoundedRectangle(cornerRadius: 30)
//                .frame(height: UIScreen.main.bounds.height * 0.5)
//                .opacity(showView ? 1.0 : 0.0)
//                .animation(.easeOut, value: showView)
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
}

struct TransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TransitionBootcamp()
        }
    }
}
