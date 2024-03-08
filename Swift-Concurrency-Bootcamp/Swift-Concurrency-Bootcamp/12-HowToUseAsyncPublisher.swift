//
//  HowToUseAsyncPublisher.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 8/3/24.
//

import SwiftUI
import Combine

class HowToUseAsyncPublisherDataManager {
    
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2000000000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2000000000)
        myData.append("Orange")
        try? await Task.sleep(nanoseconds: 2000000000)
        myData.append("Watermelon")
    }
}

class HowToUseAsyncPublisherViewModel: ObservableObject {
    
    @MainActor @Published var dataArray: [String] = []
    let manager = HowToUseAsyncPublisherDataManager()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        // now using concurrency
        Task {
            for await value in manager.$myData.values {
                await MainActor.run {
                    self.dataArray = value
                }
            }
        }
        
        
        // this is how we used to do with combine
//        manager.$myData
//            .receive(on: DispatchQueue.main)
//            .sink { dataArray in
//                self.dataArray = dataArray
//            }
//            .store(in: &cancellables)
    }
    
    func start() async {
        await manager.addData()
    }
}

struct HowToUseAsyncPublisher: View {
    @StateObject private var viewModel = HowToUseAsyncPublisherViewModel()
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
            await viewModel.start()
        }
    }
}

#Preview {
    HowToUseAsyncPublisher()
}
