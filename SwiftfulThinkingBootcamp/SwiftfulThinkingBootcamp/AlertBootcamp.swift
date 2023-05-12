//
//  AlertBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 12/5/23.
//
// #32

import SwiftUI

struct AlertBootcamp: View {
    @State var showAlert: Bool = false
    @State var backgrounColor: Color = Color.yellow
    
    @State var alertMessage: String = ""
    @State var alertTitle: String = ""
    
    var body: some View {
        ZStack {
            backgrounColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10)  {
                Button("Button 1") {
                    alertTitle = "ERROR UPLOADING VIDEO"
                    alertMessage =  "The video could not be uploaded"
                    showAlert.toggle()
                }
                
                Button("Button 2") {
                    alertTitle = "Successfully uploaded video 🥳"
                    alertMessage =  "Your video is now public!"
                    showAlert.toggle()
                }
            }
            .foregroundColor(.white)
            .font(.title)
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    
    
    // Example 1 and 2
    
//    var body: some View {
//        ZStack {
//            backgrounColor.edgesIgnoringSafeArea(.all)
//
//            Button("Click here") {
//                showAlert.toggle()
//            }
//            .foregroundColor(.white)
//            .font(.title)
//
//            //.alert("There was an error", isPresented: $showAlert) { } // example 1
//            .alert("This is the title", isPresented: $showAlert) {
//                Button("Delete", role: .destructive) {
//                    backgrounColor = .red
//                }
//
//                Button("OK", role: .cancel) {
//                    backgrounColor = .brown
//                }
//
//            } message: {
//                Text("Here we will describe the error")
//            }
//        }
//    }
}

struct AlertBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AlertBootcamp()
    }
}
