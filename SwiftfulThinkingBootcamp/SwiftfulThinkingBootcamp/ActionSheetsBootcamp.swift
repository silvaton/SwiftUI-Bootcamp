//
//  ActionSheetsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 15/5/23.
// #33

import SwiftUI

struct ActionSheetsBootcamp: View {
    
    @State private var backgroundColor: Color = .black
    @State var showActionSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text("@username")
                Spacer()
                Button {
                    showActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal)
            
            Rectangle()
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(backgroundColor)
        }
        .confirmationDialog("What would you like to do?", isPresented: $showActionSheet) {
            Button("Red") {backgroundColor = .red}
            Button("Blue") {backgroundColor = .blue}
            Button("Brown") {backgroundColor = .brown}
            Button("Orange") {backgroundColor = .orange}
            Button("Cyan") {backgroundColor = .cyan}
        }
    }
}
    
    // Example 1
//    var body: some View {
//        ZStack {
//            backgroundColor
//                .ignoresSafeArea()
//
//            Button("Click me") {
//                showActionSheet.toggle()
//            }
//            .foregroundColor(.white)
//            .confirmationDialog("This is the title",isPresented: $showActionSheet, titleVisibility: .visible) {
//                Button("Red") {backgroundColor = .red}
//                Button("Blue") {backgroundColor = .blue}
//                Button("Brown") {backgroundColor = .brown}
//                Button("Orange") {backgroundColor = .orange}
//                Button("Cyan") {backgroundColor = .cyan}
//            } message: {
//                Text("This is the message")
//            }
//        }
//    }
//}

struct ActionSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetsBootcamp()
    }
}
