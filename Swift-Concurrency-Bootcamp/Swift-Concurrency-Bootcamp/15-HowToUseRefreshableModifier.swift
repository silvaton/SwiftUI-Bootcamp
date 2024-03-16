//
//  HowToUseRefreshableModifier.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 16/3/24.
//

import SwiftUI

final class RefreshableModifierDataService {
    
    func getData() async throws -> [String] {
        // just for testing proporsal
        try? await Task.sleep(nanoseconds: 5000000000)
        return ["Apple", "Orange", "Banana"].shuffled()
    }
}

@MainActor
final class RefreshableModifierViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    
    let manager = RefreshableModifierDataService()
    
    func loadData() async {
        do {
            items =  try await manager.getData()
        } catch {
            
        }
    }
    
}

struct HowToUseRefreshableModifier: View {
    
    @StateObject private var viewModel = RefreshableModifierViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                await viewModel.loadData()
            }
            .navigationTitle("Refreshable")
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    HowToUseRefreshableModifier()
}
