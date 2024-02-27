//
//  HowToUseTaskGroup.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 27/2/24.
//

import SwiftUI

class HowToUseTaskGroupDataManager {
    let urlBase = "https://picsum.photos/300"
    
    func fetchImageWithAsynLet() async throws -> [UIImage] {
        
        async let fetchImage1 = fetchImage(urlString: urlBase)
        async let fetchImage2 = fetchImage(urlString: urlBase)
        async let fetchImage3 = fetchImage(urlString: urlBase)
        async let fetchImage4 = fetchImage(urlString: urlBase)
        
        let(image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
        
        //var images: [UIImage] = [image1, image2, image3, image4]
        //return images
        
        return [image1, image2, image3, image4]
    }
    
    //v1
    /*
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        // if the function will trhow an error, we need to use withThrowingerrorTasGroup
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            var images: [UIImage] = []
            
            group.addTask {
                try await self.fetchImage(urlString: self.urlBase)
            }
            group.addTask {
                try await self.fetchImage(urlString: self.urlBase)
            }
            group.addTask {
                try await self.fetchImage(urlString: self.urlBase)
            }
            group.addTask {
                try await self.fetchImage(urlString: self.urlBase)
            }
            
            for try await image in group {
                images.append(image)
            }
            return images
        }
    }
    */
    
    //v2
    /*
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        // if the function will trhow an error, we need to use withThrowingerrorTasGroup
        let urlStrings = [urlBase, urlBase, urlBase, urlBase, urlBase]
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask {
                    try await self.fetchImage(urlString: urlString)
                }
            }
            
            for try await image in group {
                images.append(image)
            }
            return images
        }
    }
    */
    
    //v3
    func fetchImagesWithTaskGroup() async throws -> [UIImage] { // let's use it to download the petDocuments
        
        // if the function will trhow an error, we need to use withThrowingerrorTasGroup
        let urlStrings = [urlBase, urlBase, urlBase, urlBase, urlBase]
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: urlString) //we made the try option to avoid that one error stop all the tasks
                }
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            return images
        }
    }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class HowToUseTaskGroupViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    
    let dataManager = HowToUseTaskGroupDataManager()
    
    func getImagesWithAsyncLet() async {
        if let images = try? await  dataManager.fetchImageWithAsynLet() {
            self.images.append(contentsOf: images)
        }
    }
    
    func getImagesWithTaskGroup() async {
        if let images = try? await dataManager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
}


struct HowToUseTaskGroup: View {
    @StateObject private var viewModel = HowToUseTaskGroupViewModel()
    
    let columns  = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Task Group 🥳")
            .task {
                //await viewModel.getImagesWithAsyncLet()
                await viewModel.getImagesWithTaskGroup()
            }
        }
    }
}

#Preview {
    HowToUseTaskGroup()
}
