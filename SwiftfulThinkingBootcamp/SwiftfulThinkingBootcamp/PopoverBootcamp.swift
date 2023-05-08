//
//  PopoverBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 8/5/23.
//
// #29

import SwiftUI

struct PopoverBootcamp: View {
    
    @State var showNewScreen: Bool = false
    
    var body: some View {
        ZStack {
            Color.orange
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button("Button") {
                    showNewScreen.toggle()
                }
                .font(.largeTitle)
                Spacer()
            }
            // METHOD 1 - SHEET
//            .sheet(isPresented: $showNewScreen) {
//                NewScreen()
//            }
            
            // METHOD 2 - TRANSITION - recommended
//            ZStack {
//                if showNewScreen {
//                    NewScreen(showNewScreen: $showNewScreen)
//                        .padding(.top, 100)
//                        .transition(.move(edge: .bottom))
//                        .animation(.spring(), value: showNewScreen)
//                }
//            }
//            .zIndex(2.0)
            
            // METHOD 3 - ANIMATION OFFSET
            
            NewScreen(showNewScreen: $showNewScreen)
                .padding(.top, 100)
                .offset(y: showNewScreen ? 0: UIScreen.main.bounds.height)
                .animation(.easeIn(duration: 0.5), value: showNewScreen)
        }
    }
}

struct NewScreen: View {
   
    
    @Binding var showNewScreen: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple
                .edgesIgnoringSafeArea(.all)
            
            Button {
                showNewScreen.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            }
            
        }
        
    }
            

            // METHOD 1 - SHEET
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            Color.purple
//                .edgesIgnoringSafeArea(.all)
//
//            Button {
//                dismiss.callAsFunction()
//            } label: {
//                Image(systemName: "xmark")
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//                    .padding(20)
//            }
//
//        }
//    }
}

struct PopoverBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PopoverBootcamp()
        //NewScreen()
    }
}
