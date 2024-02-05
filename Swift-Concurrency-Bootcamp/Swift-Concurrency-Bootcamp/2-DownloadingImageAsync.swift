//
//  2-DownloadingImageAsync.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 5/2/24.
//

import SwiftUI
import Combine

class DownloadingImageAsyncImageLoader {
    let url = URL(string: "https://picsum.photos/200")!
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?)-> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 &&  response.statusCode < 300 else {
                completionHandler(nil, error)
                return
            }
            completionHandler(image, nil)
        }
        .resume()
    }
    
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode  < 300 else {
            return nil
        }
        return image
    }
    
    func downloadWithEscapingV2(completionHandler: @escaping(_ image:UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self ] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher <UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil) // the await keyword make the calling/try async
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
}


class DownloadingImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let loader = DownloadingImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() {
        self.image = UIImage(systemName: "heart.fill")
    }
    
    func fetchImageWithEscaping() {
        loader.downloadWithEscaping { [weak self] image, error in // we are using [weak self] because when we call self.image inside the function we are creating a strong reference, then to avoid memory leak
            DispatchQueue.main.async { // when we call this method it is being executed in a background thread, then we need to update the view on the main thread.
                self?.image = image
            }
        }
    }
    
    func fetchImageWithCombine() {
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
    
    func fetchImageWithConcurrency() async {
        let image = try? await loader.downloadWithAsync()
        await MainActor.run { // here we are waiting to get back to the main thread
            self.image = image
        }
    }
    
}
struct DownloadingImageAsync: View {
    @StateObject private var viewModel = DownloadingImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            //viewModel.fetchImage()
            //viewModel.fetchImageWithEscaping()
            //viewModel.fetchImageWithCombine()
            
            Task {
                await viewModel.fetchImageWithConcurrency()
            }
        }
    }
}

#Preview {
    DownloadingImageAsync()
}
