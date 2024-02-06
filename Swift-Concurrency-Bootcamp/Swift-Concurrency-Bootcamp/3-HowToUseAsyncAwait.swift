//
//  HowToUseAsyncAwait.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 6/2/24.
//

import SwiftUI

class HowToUseAsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title3 = "Title3 : \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor1() async {
        // even it's an async method this code will be executed one after each other (synchronous)
        
        let author1 = "Author1 : \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2000000000) // just because we are "await"ing for something, doesn't mean we are gonna be sent (run it) in the background thread
        
        let author2 = "Author2 : \(Thread.current)"
        await MainActor.run { // this is how we move back to the main thread in concurrency
            self.dataArray.append(author2)
            let author3 = "Author3 : \(Thread.current)"
            self.dataArray.append(author3)
        }
        
        // await addSomething()
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2000000000)
        
        let something1 = "Something1 : \(Thread.current)"
        await MainActor.run { // this is how we move back to the main thread in concurrency
            self.dataArray.append(something1)
            let something2 = "Something2 : \(Thread.current)"
            self.dataArray.append(something2)
        }
    }
}


struct HowToUseAsyncAwait: View {
    @StateObject private var viewModel = HowToUseAsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) {data in
                Text(data)
            }
        }
        .onAppear {
           // viewModel.addTitle1()
           // viewModel.addTitle2()
            Task {
                // await keyword is a suspection point. it means wait ... to execute x functions.
                
                await viewModel.addAuthor1() // as this method is async, we must use await before call it.
                await viewModel.addSomething() // another example that will produce the same result
                
                let finalText = "FINAL TEXT : \(Thread.current)"
                viewModel.dataArray.append(finalText)
            }
        }
    }
}

#Preview {
    HowToUseAsyncAwait()
}
