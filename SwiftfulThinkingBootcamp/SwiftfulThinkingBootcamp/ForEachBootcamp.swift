//
//  ForEachBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 31/3/23.
//

import SwiftUI

struct ForEachBootcamp: View {
    let data = ["Hi", "Hello","Hey everyone"]
    var body: some View {
        VStack {
            ForEach(data.indices) { index in
                Text("\(data[index]): \(index)")
            }
        }
    }
    
    //Example 2
//    var body: some View {
//        VStack {
//            ForEach(0..<10) { index in
//                HStack {
//                    Circle()
//                        .frame(width: 30, height: 30)
//                    Text("Index is: \(index)")
//                }
//            }
//        }
//    }
    
    //Example 1
//    var body: some View {
//        VStack {
//            ForEach(0..<10) { index in
//                Text("Hi: \(index)")
//            }
//        }
//    }
}

struct ForEachBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ForEachBootcamp()
    }
}
