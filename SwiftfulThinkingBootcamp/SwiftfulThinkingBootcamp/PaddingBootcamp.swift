//
//  PaddingBootcamp.swift.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 27/3/23.
//

import SwiftUI

struct PaddingBootcamp: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Hello, World!")
                .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            
            Text("This is the description of what we will do on this screen. It is a multiple lines and we will align the text to the leading edge.")
        }
        .padding()
        .padding(.vertical, 10)
        .background(
            Color.white
                .cornerRadius(10)
                .shadow(
                    color: Color.black.opacity(0.30),
                    radius: 10, x: 0.0, y: 10)
        )
        .padding(.horizontal, 10)
        
        // Example 2:
//        Text("Hello, World!")
//            .font(.largeTitle)
//            .fontWeight(.semibold)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.red)
//            .padding(.leading, 20)
                
        //Example 1:
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
          //  .background(Color.yellow)
            //.padding()
            //.padding(.all, 10)
            //.padding(.leading, 20)
            //.background(Color.blue)
    }
}

struct PaddingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PaddingBootcamp()
    }
}
