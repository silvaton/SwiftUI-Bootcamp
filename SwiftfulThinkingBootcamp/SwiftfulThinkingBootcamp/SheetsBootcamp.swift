//
//  SheetsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 2/5/23.
//

import SwiftUI

struct SheetsBootcamp: View {
    
    @State var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Button")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding(20)
                    .background(Color.white.cornerRadius(10))
            }
            
            .sheet(isPresented: $showSheet) {
                SecondScreen()
            }
            
            // fullScreenCover works the same way as sheet except it covers the entire screen.
//            .fullScreenCover(isPresented: $showSheet) {
//                SecondScreen()
//            }
            


        }
    }
}

struct SecondScreen: View {
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            Button {
                dismissScreen.callAsFunction()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
                    
            }
        }
    }
}

struct SheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SheetsBootcamp()
        //SecondScreen()
    }
}
