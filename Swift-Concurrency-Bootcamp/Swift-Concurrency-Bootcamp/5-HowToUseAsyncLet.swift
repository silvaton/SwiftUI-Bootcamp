//
//  5-HowToUseAsyncLet.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 27/2/24.
//


// async let allows us to execute multiple methods at the same time and wait for the result of all of them together

import SwiftUI

struct HowToUseAsyncLet: View {
    
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/300")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Async Let Bootcamp🥳")
            .onAppear {
                Task {
                    do {
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
                        async let fetchTitle = fetchTitle()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        
                        let(image1, image2, image3, image4, title) = await(try fetchImage1, try fetchImage2, try fetchImage3 ,try fetchImage4, fetchTitle)
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        
                        
                        /*
                        let image1 = try await fetchImage()
                        self.images.append(image1)
                        
                        let image2 = try await fetchImage()
                        self.images.append(image2)
                        
                        let image3 = try await fetchImage()
                        self.images.append(image3)
                        
                        let image4 = try await fetchImage()
                        self.images.append(image4)
                        */
                    } catch  {
                        
                    }
                }
            }
        }
    }
    
    func fetchTitle() async -> String {
        return "NEW TITLE"
    }
    
    func fetchImage() async throws -> UIImage {
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

#Preview {
    HowToUseAsyncLet()
}
