//
//  ListBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Ton Silva on 10/5/23.
//
// #31

import SwiftUI

struct ListBootcamp: View {
    
    @State var fruits: [String] = [
        "apple", "orange", "banana", "peache"
    ]
    
    @State var veggies: [String] = [
        "tomato", "potato", "carrot"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit.capitalized)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical)

                    }
                    .onDelete(perform: delete) // clean version
    //                .onDelete { indexSet in
    //                    delete(indexSet: indexSet)
    //                } // standard version
                    
                    .onMove(perform: move) // clean version
//                    .onMove { indices, newOffset in
//                        move(indices: indices, newOffset: newOffset)
//                    } // standar version
                    
                    .listRowBackground(Color.pink)
                } header: {
                    HStack {
                        Text("Fruits")
                        Image(systemName: "flame.fill")
                    }
                    .font(.title)
                    .foregroundColor(.orange)
                }

                Section {
                    ForEach(veggies, id: \.self) { veggies in
                        Text(veggies.capitalized)
                            .foregroundColor(.black)
                    }
                } header: {
                    Text("Veggies")
                        .foregroundColor(.purple)
                }

            }
            .navigationTitle("Grocery List")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
        }
    }
    
    var addButton: some View {
        Button {
            add()
        } label: {
            Text("Add")
        }
    }
    
    func delete(indexSet:IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func add () {
        fruits.append("Coconut")
    }
    
    //basic example
//    var body: some View {
//        List {
//            Text("Hello, World!")
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//
//        }
//    }
}

struct ListBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ListBootcamp()
    }
}
