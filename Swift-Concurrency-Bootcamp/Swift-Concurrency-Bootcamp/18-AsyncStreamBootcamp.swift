//
//  AsyncStreamBootcamp.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 16/3/24.
//

import SwiftUI

class AsyncStreamDataManager {
    
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream { [weak self] continuation in
            self?.getFakeData(newValue: { value in
                continuation.yield(value)
            }, onFinish: { error in
                continuation.finish(throwing: error)
            })
        }
    }
    
    func getFakeData(newValue: @escaping (_ value: Int) -> Void,
                     onFinish: @escaping(_ error: Error?) -> Void) {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                newValue(item)
                print("NEW DATA: \(item)")
                
                if item == items.last {
                    onFinish(nil)
                }
            })
        }
    }
}

@MainActor
final class AsyncStreamBootcampViewModel: ObservableObject {
    private let dataManager = AsyncStreamDataManager()
    
    @Published private(set) var currentNumber: Int = 0
    
    func onViewAppear() {
        //        dataManager.getFakeData { [weak self] value in
        //            self?.currentNumber = value
        //        }
        
        let task = Task {
            do {
                for try await value in dataManager.getAsyncStream() {
                    currentNumber = value
                }
            } catch {
                print(error)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            task.cancel()
            print("TASK CANCELLED!")
        })
    }
}

struct AsyncStreamBootcamp: View {
    
    @StateObject private var viewModel = AsyncStreamBootcampViewModel()
    
    var body: some View {
        Text("\(viewModel.currentNumber)")
            .onAppear {
                viewModel.onViewAppear()
            }
    }
}

#Preview {
    AsyncStreamBootcamp()
}
