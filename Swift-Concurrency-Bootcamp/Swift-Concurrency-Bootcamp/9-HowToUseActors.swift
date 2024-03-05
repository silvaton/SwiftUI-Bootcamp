//
//  HowToUseActors.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 5/3/24.
//

import SwiftUI

// 1. What is the problem that actor is solving?
/// data racing, when two  different threads are accing the same object at the same time in memory.
// 2. How was this problem solved prior to actors?
// 3. Actors can solve the problem!
/// Actors are thread safe by default, they are thread safe because we need to await in order to get in that actor


// The DataManager that generate the problem of Data Race - aka V1
/*
class MyDataManager {
    
    static let instance = MyDataManager()
    private init() { }
    
    var data: [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
}

 */

// The DataManager with the solution without actors- aka V2 - the solution to make classes safe
/*
class MyDataManager {
    static let instance = MyDataManager()
    
    private init() { }
    private let lock /* queue or lock */ = DispatchQueue(label: "com.MyApp.MyDataManager")
    
    var data: [String] = []
    
    func getRandomData(completionHandler: @escaping (_ title: String?) -> ()) {
        lock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
}

struct HomeView: View {
    
    let manager = MyDataManager.instance
    
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            DispatchQueue.global(qos: .background).async {
                manager.getRandomData { title in
                    if let data = title {
                        DispatchQueue.main.async {
                            self.text = data
                        }
                    }
                }
            }
        })
    }
}

struct BrowseView: View {
    
    let manager = MyDataManager.instance
    
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            DispatchQueue.global(qos: .background).async {
                manager.getRandomData { title in
                    if let data = title {
                        DispatchQueue.main.async {
                            self.text = data
                        }
                    }
                }
            }
        })
    }
}
*/

// The DataManager as an Actor

actor MyActorDataManager {
    static let instance = MyActorDataManager()
    
    private init() { }
    
    var data: [String] = []
    nonisolated let randomtext: String = "fdskfskljflsjflsadlf" // this means that this constant is not isolated to the actor as well as we don't need to await to get into the actor in order to access it.
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    
    nonisolated func getSavedData() -> String { // this means that this function is not isolated to the actor as well as we don't need to await to get into the actor in order to access it.
        return "NEW DATA"
    }
}
struct HomeView: View {
    
    let manager = MyActorDataManager.instance
    
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear {
            let newString = manager.getSavedData()
            
            Task {
               let data = await manager.data // with actors, we need to "await" to get/access tha data from it
            }
        }
        .onReceive(timer, perform: { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run { // I need to switch back to the Main Thread
                        self.text = data
                    }
                }
            }
        })
    }
}

struct BrowseView: View {
    
    let manager = MyActorDataManager.instance
    
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run { // I need to switch back to the Main Thread
                        self.text = data
                    }
                }
            }
        })
    }
}

struct HowToUseActors: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Home", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    HowToUseActors()
}
