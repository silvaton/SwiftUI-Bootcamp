//
//  HowToUseSensableProtocol.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 7/3/24.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDataBase(userInfo: MyClassUserInfo) {
        
    }
}

struct MyUserInfo: Sendable /* when we create data models that will be used in async enviroment, the compiler will know that it's safe, it's good to marke it as Sendable*/ {
    var name: String
}

final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    let queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo") // making the class thread safe
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {  // making the class thread safe
            self.name = name
        }
    }
}

class HowToUseSensableProtocolViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyClassUserInfo(name: "info")
        await manager.updateDataBase(userInfo: info)
    }
}

struct HowToUseSensableProtocol: View {
    @StateObject private var viewModel = HowToUseSensableProtocolViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                
            }
    }
}

#Preview {
    HowToUseSensableProtocol()
}
