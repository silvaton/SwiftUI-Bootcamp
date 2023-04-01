//
//  SafeAreaBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 31/3/23.
//

import SwiftUI

struct SafeAreaBootcamp: View {
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Title goes here")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(height: 150)
                        .shadow(radius: 10)
                        .padding(20)
                }
            }
        }
        //.background(Color.red.edgesIgnoringSafeArea(.all)) // old
        .background(
            Color.red
                .ignoresSafeArea(edges: .all) // new
        )
    }
    
  // Example 1:
//    var body: some View {
//        ZStack {
//            // background
//            Color.blue.edgesIgnoringSafeArea(.all)
//
//            //foreground
//            VStack {
//                Text("Hello, World!")
//                Spacer()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.red.edgesIgnoringSafeArea(.horizontal))
//        }
//    }
}

struct SafeAreaBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaBootcamp()
    }
}
