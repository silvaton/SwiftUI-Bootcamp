//
//  ScrollViewBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 31/3/23.
//

import SwiftUI

struct ScrollViewBootcamp: View {
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10) { index in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<20) { index in
                                if index % 2 == 1 {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(.white)
                                        .frame(width: 200, height: 150)
                                        .shadow(color: .yellow,radius: 10)
                                        .padding()
                                } else {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(.white)
                                        .frame(width: 200, height: 150)
                                        .shadow(color: .red,radius: 10)
                                        .padding()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Example 5:
//    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(0..<10) { index in
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHStack {
//                            ForEach(0..<20) { index in
//                                RoundedRectangle(cornerRadius: 25.0)
//                                    .fill(.white)
//                                    .frame(width: 200, height: 150)
//                                    .shadow(color: .red,radius: 10)
//                                    .padding()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    //Example 4
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(0..<10) { index in
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(0..<20) { index in
//                                RoundedRectangle(cornerRadius: 25.0)
//                                    .fill(.white)
//                                    .frame(width: 200, height: 150)
//                                    .shadow(color: .yellow,radius: 10)
//                                    .padding()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    //Example 3:
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(0..<50) { index in
//                    Rectangle()
//                        .fill(Color.cyan)
//                        .frame(width: 300, height: 300)
//                }
//            }
//        }
//    }
    
    //Example 2:
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack {
//                ForEach(0..<50) { index in
//                    Rectangle()
//                        .fill(Color.cyan)
//                        .frame(height: 300)
//                }
//            }
//        }
//    }
    
    //Example 1:
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(0..<50) { index in
//                    Rectangle()
//                        .fill(Color.blue)
//                        .frame(height: 300)
//                }
//            }
//        }
//    }
}

struct ScrollViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewBootcamp()
    }
}
