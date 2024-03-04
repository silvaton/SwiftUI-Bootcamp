//
//  StructClassActor.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 28/2/24.
//

/*
 https://www.youtube.com/watch?v=-JLenSTKEcA&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=9
 
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread Safe
 - When you assign or pass a value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Funcion, Actor
 - Stored in the Heap
 - Slower, but synchronized
 - NOT Thread Safe (by default)
 - When you assign or pass reference a new reference to original instance will be created (pointer)
 
 ---------------------------------------
 
 STACK:
 - Stores Value Types
 - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast
 - Each thread has it's on stack!
 
 HEAP:
 - Store Reference Types
 - Shared across threads!
 
 ---------------------------------------
 
 STRUCT:
 - Based on VALUES
 - Can be mutated
 - Stored in the Stack!
 
 CLASS:
 - Based on REFERENCES (INSTANCES)
 - Stored in the Heap!
 - Inherit from other classes
 
 ACTOR:
 - Same as Class, but thread safe!
  
 ---------------------------------------
 
 Structs: Data Models, Views
 Classes: ViewModels
 Actors: Shared "Manager" and "Data Store"

 */

import SwiftUI

actor StructClassActorDataManager {
    func getDataFromDataBase() {
        
    }
}

class StructClassActorViewModel: ObservableObject {
    @Published var title: String = ""
    
    init() {
        print("ViewModel INIT")
    }
}

struct StructClassActor: View {
    
    @StateObject private var viewModel = StructClassActorViewModel()
    let isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
        print("View INIT")
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(isActive ? Color.red : Color.blue)
            .onAppear(perform: {
                //runTest()
            })
    }
}

struct StructClassActorHomeView: View {
    
    @State private var isActive: Bool = false
    var viewCounter = 0
    
    var body: some View {
        StructClassActor(isActive: isActive)
            .onTapGesture {
                isActive.toggle()
            }
    }
}

#Preview {
    StructClassActor(isActive: true)
}



extension StructClassActor {
    
    private func runTest() {
        print("Text Started!")
        structTest1()
        printDivider()
        classTest1()
        printDivider()
        actorTest1()
        
//        structTest2()
//        printDivider()
//        classTest2()
    }
    
    private func printDivider() {
        print("""
        
        -------------------------

        """)
    }
    
    private func structTest1() {
        print("Struct Test1")
        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the VALUES of objectA to objectB.")
        var objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second Title!"
        print("ObjectB title changed!")
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    private func classTest1() {
        print("Class Test1")
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the REFERENCES of objectA to objectB.")
        let objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second Title!"
        print("ObjectB title changed!")
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    private func actorTest1() {
        /*
         the diff between class and actor, is that actor is a thread safe. but...
         Actors recquires us to be in an async enviroment
         when we want to access anything from inside the actor we need to await on it
         */
        
        Task {
            print("actorTest1")
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: ", objectA.title)
            
            print("Pass the REFERENCES of objectA to objectB.")
            let objectB = objectA
            await print("ObjectB: ", objectB.title)
            
            await objectB.updateTitle(newTitle: "Second Title!")
            print("ObjectB title changed!")
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
        }
    }
    
}


struct MyStruct {
    var title: String
}

// Immutable struct
struct CustomStruct { //the most recommend by nick
    let title: String
    
    func updateTitle(newString: String) -> CustomStruct {
        CustomStruct(title: newString)
    }
}

struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle: String) {
        title = newTitle // here we are changing the whole struct
    }
}

extension StructClassActor {
    private func structTest2() {
        print("structTest2")
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: ", struct1.title)
        struct1.title =  "Title2"
        print("Struct1: ", struct1.title)
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2: ", struct2.title)
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newString: "Title2")
        print("Struct3: ", struct3.title)
        
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4: ", struct4.title)
    }
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

extension StructClassActor {
    
    private func classTest2() {
        print("classTest2")
        
        let class1 = MyClass(title: "Title1")
        print("Class1: ", class1.title)
        class1.title = "Title2"
        print("Class1: ", class1.title)
        
        let class2 = MyClass(title: "Title1")
        print("Class2: ", class1.title)
        class1.updateTitle(newTitle: "Title2")
        print("Class2: ", class1.title)
        
        let class3 = MyClass(title: "Title3")
        print("Class3: ", class3.title)
        let class4 = class3
        class4.title = "Title4"
        print("Class3: ", class3.title, "Class4: ", class4.title)
    }
}

// MARK: - Notes
/*
 Value type: Struct, Enum, tuple, string, array, dictionary)
 Reference type: Class and Function
 
 
 */
