//
//  ObservableBootcamp.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 16/3/24.
//

import SwiftUI

actor TitleDataBase {
    
    func getNewTitle() -> String {
        "Some new Title"
    }
}

@Observable class ObservableViewModel {//only available on ios 17
    
    @MainActor var title: String = "Starting Title"
    
    @ObservationIgnored let dataBase = TitleDataBase()
    
    //@MainActor - one option
    func updateTitle() async {
        let response = await dataBase.getNewTitle()
        
        await MainActor.run { // second option
            self.title = response
        }
    }
    
    func updateTitle2() {
        Task { @MainActor in
            title = await dataBase.getNewTitle()
        }
    }
}

struct ObservableBootcamp: View {
    
    @State private var viewModel = ObservableViewModel()
    
    var body: some View {
        Text(viewModel.title)
            .task {
                await viewModel.updateTitle()
            }
            .onAppear {
                viewModel.updateTitle2() //third option
            }
    }
}

#Preview {
    ObservableBootcamp()
}
