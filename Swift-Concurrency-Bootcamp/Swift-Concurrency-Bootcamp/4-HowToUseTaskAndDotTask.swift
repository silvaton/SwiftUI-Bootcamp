//
//  4-HowToUseTaskAndDotTask.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 27/2/24.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5000000000)
        
        for x in [1,3,5] {
            print("\(x)")
            try? Task.checkCancellation() // this is a way to check if the task was cancelled and it throws an error 
        }
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.image = UIImage(data: data)
                print("IMAGE RETURNED SUCCESSFULLY!")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.image2 = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("CLICK ME! 🤓") {
                    HowToUseTaskAndDotTask()
                }
            }
        }
    }
}

struct HowToUseTaskAndDotTask: View {
    @StateObject private var viewModel = TaskBootcampViewModel()
    
    @State private var fetchImageTask: Task<(), Never>? = nil // this should be in the viewModel
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage() // swift ui will automatically cancel the task if the view dissapear before the action completes
        }
        .onDisappear(perform: {
           /* fetchImageTask?.cancel() */
        })
        .onAppear(perform: {
            /*
            self.fetchImageTask = Task {
                await viewModel.fetchImage()
            }
            */
            /*
            Task {
                print(Thread.current)
                print(Task.currentPriority)
                await viewModel.fetchImage()
            }
            
            Task {
                print(Thread.current)
                print(Task.currentPriority)
                await viewModel.fetchImage2()
            }
            */
            
            /*
            Task(priority: .high) {
                //try? await Task.sleep(nanoseconds:2000000000)
                await Task.yield() // suspend the taks and wait for the others to be called
                print("high : \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .userInitiated) {
                print("userInitiated : \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .medium) {
                print("medium : \(Thread.current) : \(Task.currentPriority)")
            }

            Task(priority: .low) {
                print("low : \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .utility) {
                print("utility : \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .background) {
                print("background : \(Thread.current) : \(Task.currentPriority)")
            }
            
            */
            
            /*
            Task(priority: .low) {
                print("low : \(Thread.current) : \(Task.currentPriority)")
                
                Task {
                    print("low : \(Thread.current) : \(Task.currentPriority)") // the child will inherit the priorit from his parents
                }
                
                Task.detached {
                    print("detached : \(Thread.current) : \(Task.currentPriority)") // if I don't want to inherit the priorit from the parents, I can use .detached. *but don't use it*
                }
            }
            */
        })
    }
}

#Preview {
    HowToUseTaskAndDotTask()
}
