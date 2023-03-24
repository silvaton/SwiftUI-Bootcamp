//
//  StacksBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 24/3/23.
//

import SwiftUI

struct StacksBootcamp: View {
    // Vstacks -> Vertical
    // Hstacks -> Horizontal
    // Zstacks -> change the zIndex (back to front / it layers things in front and behind of each other)
    var body: some View {
        //Example 6:
        VStack(spacing: 50) {
            
            ZStack { // use it when you want to stack a bunch of elements (complex elements)
                Circle()
                    .frame(width: 100, height: 100)
                
                Text("1")
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            Text("1")
                .font(.title)
                .foregroundColor(.white)
                .background { // use it when you want to overlay one, two or three elements
                    Circle()
                        .frame(width: 100, height: 100)
                }
        }
        
        
        // Example 5:
//        VStack(alignment: .center, spacing: 20) {
//            Text("5")
//                .font(.largeTitle)
//                .underline()
//            Text("Items in your cart")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
        
        // Example 4:
//        ZStack (alignment: .top, content: {
//            Rectangle()
//                .fill(.yellow)
//                .frame(width: 350, height: 500, alignment: .center)
//
//            VStack (alignment: .leading, spacing: 30) {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 150, height: 150)
//
//                Rectangle()
//                    .fill(.green)
//                    .frame(width: 100, height: 100)
//
//                HStack (alignment: .bottom) {
//                    Rectangle()
//                        .fill(.purple)
//                    .frame(width: 50, height: 50)
//
//                    Rectangle()
//                        .fill(.pink)
//                        .frame(width: 75, height: 75)
//
//                    Rectangle()
//                        .fill(.blue)
//                        .frame(width: 25, height: 25)
//                }
//                .background(Color.white)
//            }
//            .background(Color.black)
//        })
        
        // Example 3:
//        ZStack(alignment: .topLeading) {
//            Rectangle()
//                .fill(.red)
//                .frame(width:200, height: 200)
//
//            Rectangle()
//                .fill(.green)
//                .frame(width:150, height: 150)
//
//            Rectangle()
//                .fill(.orange)
//                .frame(width:100, height: 100)
//        }
        
        // Example 2:
//        HStack(alignment: .bottom, spacing: nil) {
//            Rectangle()
//                .fill(.red)
//                .frame(width:200, height: 200)
//
//            Rectangle()
//                .fill(.green)
//                .frame(width:150, height: 150)
//
//            Rectangle()
//                .fill(.orange)
//                .frame(width:100, height: 100)
//        }
        
        // Example 1:
//        VStack {
//            Rectangle()
//                .fill(.red)
//                .frame(width:100, height: 100)
//
//            Rectangle()
//                .fill(.green)
//                .frame(width:100, height: 100)
//
//            Rectangle()
//                .fill(.orange)
//                .frame(width:100, height: 100)
//        }
    }
}

struct StacksBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StacksBootcamp()
    }
}
