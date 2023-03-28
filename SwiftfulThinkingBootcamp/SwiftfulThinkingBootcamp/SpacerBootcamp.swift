//
//  SpacerBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 27/3/23.
//

import SwiftUI

struct SpacerBootcamp: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                
                Image(systemName: "xmark")
                Spacer()
                    .frame(height: 10)
                   // .background(Color.orange)
                Image(systemName: "gear")
                
                //Example 01
    //            Spacer(minLength: 0)
    //                .frame(height: 10)
    //                .background(Color.orange)
    //
    //            Rectangle()
    //                .frame(width: 50, height: 50)
    //
    //            Spacer()
    //                .frame(height: 10)
    //                .background(Color.orange)
    //
    //            Rectangle()
    //                .fill(Color.red)
    //                .frame(width: 50, height: 50)
    //
    //            Spacer()
    //                .frame(height: 10)
    //                .background(Color.orange)
    //
    //            Rectangle()
    //                .fill(Color.green)
    //                .frame(width: 50, height: 50)
    //
    //            Spacer(minLength: 0)
    //                .frame(height: 10)
    //                .background(Color.orange)
            }
            .font(.title)
           // .background(Color.yellow)
            .padding(.horizontal)
            //.background(Color.blue)
            
            Spacer()
                .frame(width: 10)
                //.background(Color.orange)
            
            Rectangle()
                .frame(height: 55)
        }
        .background(Color.yellow)
    }
}

struct SpacerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SpacerBootcamp()
    }
}
