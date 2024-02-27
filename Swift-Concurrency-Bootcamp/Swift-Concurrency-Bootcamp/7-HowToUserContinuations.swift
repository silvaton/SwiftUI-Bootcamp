//
//  HowToUserContinuations.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 27/2/24.
//


//we use continuations to make compatible apis that is not updated for concurrency.
// to convert something that is not async await to async await
// to convert no asyncronous code to asyncronous code

import SwiftUI

class HowToUserContinuationsNetworkManager {
    
    func getData(url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func getHeartImageFromDataBase(completionHandler: @escaping(_ image: UIImage) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDataBase() async -> UIImage {
        return await withCheckedContinuation { continuation in
            getHeartImageFromDataBase { image in
                continuation.resume(returning: image)
            }
        }
    }
}

class HowToUserContinuationsViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let networkManager = HowToUserContinuationsNetworkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300") else { return }
        
        do {
            let data = try await networkManager.getData(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getImage2() async {
        guard let url = URL(string: "https://picsum.photos/300") else { return }
        
        do {
            let data = try await networkManager.getData(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getHeartImage() {
        networkManager.getHeartImageFromDataBase { [weak self] image in
            self?.image = image
        }
    }
    
    func getHeartImage2() async {
        self.image = await networkManager.getHeartImageFromDataBase()
    }
}

struct HowToUserContinuations: View {
    @StateObject private var viewModel = HowToUserContinuationsViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            //await viewModel.getImage2()
            await viewModel.getHeartImage2()
        }
    }
}

#Preview {
    HowToUserContinuations()
}
