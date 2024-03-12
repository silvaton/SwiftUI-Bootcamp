//
//  MVVMConcurrency.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 12/3/24.
//

import SwiftUI

final class MyManagerClass {
    func getData() async throws -> String {
        "Some Data!"
    }
}

actor MyManagerActor {
    func getData() async throws -> String {
        "Some Data!"
    }
}

@MainActor
final class MVVMConcurrencyViewModel: ObservableObject {
    let managerClass = MyManagerClass()
    let managerActor = MyManagerActor()
    
    @Published private(set) var myData: String = "Starting text"
    private var tasks: [Task<Void, Never>] = []
    
    func cancelTasks() {
        tasks.forEach({$0.cancel()})
        tasks = []
    }
    func onCallToActionButtonPressed() {
        let task  = Task {
            do {
                //myData = try await managerClass.getData()
                myData = try await managerActor.getData()
            } catch {
                print(error)
            }
        }
        tasks.append(task)
    }
    
}

struct MVVMConcurrency: View {
    @StateObject private var viewModel = MVVMConcurrencyViewModel()
    
    var body: some View {
        VStack {
            Button(viewModel.myData) {
                viewModel.onCallToActionButtonPressed()
            }
        }
        .onDisappear {
            viewModel.cancelTasks()
        }
    }
}

#Preview {
    MVVMConcurrency()
}
