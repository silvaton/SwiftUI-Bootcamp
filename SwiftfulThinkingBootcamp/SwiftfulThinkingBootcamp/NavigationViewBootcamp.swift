//
//  NavigationViewBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 9/5/23.
//
// #30

import SwiftUI

struct NavigationViewBootcamp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
               // NavigationLink("Hello, World",
                               //destination: Text("Second screen")) example one
                
                NavigationLink("My other screen", destination: MyOtherScreen())
                Text("Hello, World!")
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("All Inboxes")
            //.navigationBarTitleDisplayMode(.automatic) // changes de navbar title size
            .toolbar(id: "profile") {
                ToolbarItem(id: "about us",placement: .primaryAction) {
                    NavigationLink {
                        MyOtherScreen()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.red)
                    }

                    
//                    Button {
//
//                    } label: {
//                        Image(systemName: "person.fill")
//                    }
                }
                
                ToolbarItem(id: "settings",placement: .primaryAction) {
                    Button {
                        
                    } label: {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.purple)
                    }
                }
            }
        }
    }
}

struct MyOtherScreen: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
                .navigationTitle("Green Screen")
                .toolbar(.hidden, for: .automatic)
                        
            VStack(spacing: 5) {
                Button("Back Button") {
                    dismiss.callAsFunction()
                }
                NavigationLink("Click here", destination: Text("Third screen"))
            }
        }
        
    }
}

struct NavigationViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewBootcamp()
    }
}
