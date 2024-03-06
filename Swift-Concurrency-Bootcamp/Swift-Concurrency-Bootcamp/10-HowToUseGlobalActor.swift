//
//  HowToUseGlobalActor.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 6/3/24.
//

import SwiftUI

// If you have anything on your app that you want to run in the Main Thread, mark it as @MainActor

@globalActor final class/* no one can inherit from this class*/ MyFirstGlobalActor {
    
    static var shared = MyNewDataManager()
}

/*
 @globalActor struct MyFirstGlobalActor {
    
    static var shared = MyNewDataManager()
}
*/
actor MyNewDataManager {
    
    func getDataFromDataBase() -> [String] {
        
        return ["One", "Two", "Three", "Four", "Five"]
    }
}

class HowToUseGlobalActorViewModel: ObservableObject {
    @MainActor @Published var dataArray: [String] = [] // This Variable is now Isolated to the MainActor. Everything that updates an UI must be on MainActor
    let manager = MyFirstGlobalActor.shared
    
    @MyFirstGlobalActor /* This also could be @MainActor*/func getData() {
        Task {
            let data = await manager.getDataFromDataBase()
            await MainActor.run {
                self.dataArray = data
            }
        }
    }
}

struct HowToUseGlobalActor: View {
    @StateObject private var viewModel = HowToUseGlobalActorViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    HowToUseGlobalActor()
}
// Simple example of how to use an Actor
/*
 
 actor MyNewDataManager {
     
     func getDataFromDataBase() -> [String] {
         
         return ["One", "Two", "Three"]
     }
 }

 class HowToUseGlobalActorViewModel: ObservableObject {
     @Published var dataArray: [String] = []
     let manager = MyNewDataManager()
     
     func getData() async {
         let data = await manager.getDataFromDataBase()
         self.dataArray = data
     }
 }

 struct HowToUseGlobalActor: View {
     @StateObject private var viewModel = HowToUseGlobalActorViewModel()
     
     
     var body: some View {
         ScrollView {
             VStack {
                 ForEach(viewModel.dataArray, id: \.self) {
                     Text($0)
                         .font(.headline)
                 }
             }
         }
         .task {
             await viewModel.getData()
         }
     }
 }

 */
