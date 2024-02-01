//
//  1-DoTryCatchThrows.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 1/2/24.
//

import SwiftUI
// do-catch
// try
// throws


class DoTryCatchThrowsDataManager {
    
    // for examples 1...3
    //let isActive: Bool = false
    
    // for example 4
    let isActive: Bool = true
    
//    func getTitle() -> String? {
//        if isActive {
//            return "NEW TEXT"
//        } else {
//            return nil
//        }
//    }
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TEXT", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "NEW TEXT"
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "FINAL TEXT!"
        } else {
            throw URLError(.serverCertificateHasBadDate)
        }
    }
    
    func getTitle5() throws -> String {
        throw URLError(.serverCertificateHasBadDate)
    }
    
}

class DoTryCatchThrowsViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text."
    let manager = DoTryCatchThrowsDataManager()
    
//    func fetchTitle() {
//        let newTitle = manager.getTitle()
//        if let newTitle = newTitle {
//            self.text = newTitle
//        }
//    }
    
    func fetchTitle() {
        // example 1
        /*
        let returnedValue = manager.getTitle()
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
         */
        
        // example 2
        /*
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
            
        case .failure(let error):
            self.text = error.localizedDescription
        }
         */
        
        // example 3
        /*
        do {
            let newTitle = try manager.getTitle3()
            self.text = newTitle
        } catch {
            self.text = error.localizedDescription
            
        }
         */
        
        // example 4
        /*
        do {
            // if one of the try fails it will automatically throw the erro inside of the catch
            let newTitle = try manager.getTitle3()
            self.text = newTitle
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
            
        } catch {
            self.text = error.localizedDescription
        }
        */
        
        // example 5
        /// if I don't care about the error, I can use the "try?" + "if let"  instead of do catch block
        /*
        let newTitle = try? manager.getTitle5()
        if let newTitle = newTitle {
            self.text = newTitle
        }
         */
        
        // example 6
        /// using the try? inside of a do catch block, means that if the method fails, but the others don't it wont throw the error of the one who fails
        do {
            let newTitle = try? manager.getTitle5()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch {
            self.text = error.localizedDescription
        }
    }
}


struct DoTryCatchThrows: View {
    @StateObject private var viewModel = DoTryCatchThrowsViewModel()
    
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoTryCatchThrows()
}
