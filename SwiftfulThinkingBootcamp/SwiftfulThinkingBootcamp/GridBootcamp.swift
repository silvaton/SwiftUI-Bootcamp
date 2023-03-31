//
//  GridBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 31/3/23.
//

import SwiftUI

struct GridBootcamp: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        
    ]
    var body: some View {
        ScrollView(showsIndicators: false) {
            Rectangle()
                .fill(Color.orange)
                .frame(height: 400)
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 6,
                      pinnedViews: [.sectionHeaders]) {
                Section(header:
                    Text("Section 1")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.cyan)
                    .cornerRadius(10)
                    .padding()
                    
                ) {
                    ForEach(0..<20) {index in
                        Rectangle()
                            .frame(height: 150)
                    }
                }
                
                Section(header:
                    Text("Section 2")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.mint)
                    .cornerRadius(10)
                    .padding()
                    
                ) {
                    ForEach(0..<20) {index in
                        Rectangle()
                            .fill(Color.indigo)
                            .frame(height: 150)
                            
                    }
                }
            }
        }
    }
    
    // Example 4: Instagram Profile
//    let columns: [GridItem] = [
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//
//    ]
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//
//            Rectangle()
//                .fill(Color.white)
//                .frame(height: 400)
//
//            LazyVGrid(columns: columns) {
//                ForEach(0..<50) { index in
//                    Rectangle()
//                        .frame(height: 150)
//                }
//            }
//        }
//    }

    // Example 3:
//    let columns: [GridItem] = [
//        GridItem(.adaptive(minimum: 10, maximum: 300), spacing: nil, alignment: nil),
//        GridItem(.adaptive(minimum: 150, maximum: 300), spacing: nil, alignment: nil),
//
//    ]
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            ForEach(0..<50) { index in
//                Rectangle()
//                    .frame(height: 50)
//            }
//        }
//    }
        
    //Example 2:
//    let columns: [GridItem] = [
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//    ]
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            ForEach(0..<50) { index in
//                Rectangle()
//                    .frame(height: 50)
//            }
//        }
//    }
    
    // Example 1:
//    let columns: [GridItem] = [
//        GridItem(.fixed(50), spacing: nil, alignment: nil),
//        GridItem(.fixed(75), spacing: nil, alignment: nil),
//        GridItem(.fixed(100), spacing: nil, alignment: nil),
//        GridItem(.fixed(85), spacing: nil, alignment: nil),
//        GridItem(.fixed(50), spacing: nil, alignment: nil)
//    ]
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            ForEach(0..<50) { index in
//                Rectangle()
//                    .frame(height: 50)
//            }
//        }
//    }
}

struct GridBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GridBootcamp()
    }
}
