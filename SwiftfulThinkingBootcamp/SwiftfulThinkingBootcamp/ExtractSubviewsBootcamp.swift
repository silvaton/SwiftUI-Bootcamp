//
//  ExtractSubviewsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 4/4/23.
//

import SwiftUI

struct ExtractSubviewsBootcamp: View {
    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)

            contentLayer
        }
    }
    
    var contentLayer: some View {
        HStack {
            MyItem(title: "Apple", count: 20, color: .red)
            MyItem(title: "Orange", count: 35, color: .orange)
            MyItem(title: "Bananas", count: 50, color: .yellow)
        }
    }
}

struct ExtractSubviewsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ExtractSubviewsBootcamp()
    }
}

struct MyItem: View {
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text("\(count)")
            Text(title)
        }
        .padding()
        .background(color)
        .cornerRadius(10)
    }
}
