//
//  SearchableBootcamp.swift
//  Swift-Concurrency-Bootcamp
//
//  Created by Ton Silva on 16/3/24.
//

import SwiftUI
import Combine // this is being used in the viewModel

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

enum CuisineOption: String {
    case american, italian, japanese
}

final class RestaurantManager {
    
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
            Restaurant(id: "4", title: "Local Market", cuisine: .american)
        ]
    }
}

@MainActor
final class SearchableViewModel: ObservableObject {
    
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    @Published var searchScope: SearchScopeOption = .all
    @Published private(set) var allSearchScopes: [SearchScopeOption] = []
    
    let manager = RestaurantManager()
    private var cancellables =  Set<AnyCancellable>()
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    var showSearchSuggestions: Bool {
        searchText.count < 5
    }
    
    // this is for the ScopeOption
    enum SearchScopeOption: Hashable {
        case all
        case cuisine(option: CuisineOption)
        
        var title: String {
            switch self {
            case .all:
                return "All"
            case .cuisine(option: let option):
                return option.rawValue.capitalized
            }
        }
    }
    
    init () {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main) // after 0.3 seconds user stop typing, execute...
            .sink { [weak self] (searchText, searchScope) in
                self?.filterRestaurants(searchText: searchText, currentSearchScope: searchScope)
            }
            .store(in: &cancellables)
    }
    
    private func filterRestaurants(searchText: String, currentSearchScope: SearchScopeOption) {
        guard !searchText.isEmpty else {
            filteredRestaurants = []
            searchScope = .all
            return
        }
        
        // Filter on search scope
        var restaurantInScope = allRestaurants
        switch currentSearchScope {
        case .all:
            break
        case .cuisine(let option):
            //            restaurantInScope = allRestaurants.filter({ restaurant in
            //                return restaurant.cuisine == option
            //            })
            
            restaurantInScope = allRestaurants.filter({$0.cuisine == option}) // short form
        }
        
        // Filter on search Text
        let search = searchText.lowercased()
        filteredRestaurants = restaurantInScope.filter({ restaurant in
            let titleContainsSearch = restaurant.title.lowercased().contains(search)
            let cuisineContainsSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            return titleContainsSearch || cuisineContainsSearch // this means that it will return a list of places if the typed text contains the title or cuisine elements in the list
        })
    }
    
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurants()
            
            // we are gonna map all restaurants into a cousine.
            
            /// doing this way we can get italian repeated ten times.
            //let allCuisines = allRestaurants.map { $0.cuisine }
            
            /// so we "Set" the values to be unique:
            let allCuisines = Set(allRestaurants.map { $0.cuisine })
            
            //            allSearchScopes = [.all] + allCuisines.map({ option in
            //                SearchScopeOption.cuisine(option: option)
            //            })
            
            allSearchScopes = [.all] + allCuisines.map({SearchScopeOption.cuisine(option: $0)}) // short version
            
        } catch {
            print(error)
        }
    }
    
    func getSearchSuggestions() -> [String] {
        guard showSearchSuggestions else {
            return [] // doing it after user sellect one of the suggetion, the list will disappear
        }
        var suggestions: [String] = []
        
        let search = searchText.lowercased()
        
        if search.contains("pa"){
            suggestions.append("Pasta")
        }
        if search.contains("su"){
            suggestions.append("Sushi")
        }
        if search.contains("pa"){
            suggestions.append("Burger")
        }
        suggestions.append("Market")
        suggestions.append("Grocery")
        
        suggestions.append(CuisineOption.italian.rawValue.capitalized)
        suggestions.append(CuisineOption.american.rawValue.capitalized)
        suggestions.append(CuisineOption.japanese.rawValue.capitalized)
        
        
        return suggestions
    }
    
    func getRestaurantSuggestions() -> [Restaurant] {
        guard showSearchSuggestions else {
            return [] // doing it after user sellect one of the suggetion, the list will disappear
        }
        
        var suggestions: [Restaurant] = []
        
        let search = searchText.lowercased()
        
        if search.contains("ita") {
            suggestions.append(contentsOf: allRestaurants.filter({$0.cuisine == .italian}))
        }
        if search.contains("jap") {
            suggestions.append(contentsOf: allRestaurants.filter({$0.cuisine == .japanese}))
        }
        
        return suggestions
    }
}

struct SearchableBootcamp: View {
    @StateObject private var viewModel = SearchableViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.isSearching ?
                        viewModel.filteredRestaurants : viewModel.allRestaurants) {restaurant in
                    NavigationLink(value: restaurant) {
                        restaurantRow(restaurant: restaurant)
                    }
                }
            }
            .padding()
            
            // - another way to watch if the user is typing something is to use a child view as you can see bellow
            /*
            Text("ViewModel is searching: \(viewModel.isSearching.description)")
            SearchChildView()
            */
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: Text("Search restaurants..."))
        .searchScopes($viewModel.searchScope, scopes: {
            ForEach(viewModel.allSearchScopes, id: \.self) { scope in
                Text(scope.title)
                    .tag(scope)
            }
        })
        .searchSuggestions({
            //Text("Hello World") //suggestion profile on instagram or for recent researches
            
            ForEach(viewModel.getSearchSuggestions(), id: \.self) { suggestion in
                Text(suggestion)
                    .searchCompletion(suggestion)
            }
            
            ForEach(viewModel.getRestaurantSuggestions(), id: \.self) { suggestion in
                NavigationLink(value: suggestion) {
                    Text(suggestion.title)
                }
            }
            
        })
        //.navigationBarTitleDisplayMode(.inline) // option
        .navigationTitle("Restaurants")
        .task {
            await viewModel.loadRestaurants()
        }
        .navigationDestination(for: Restaurant.self) { restaurant in
            Text(restaurant.title.uppercased())
        }
    }
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.title)
                .font(.headline)
                .foregroundStyle(.red) // changed because now will be a navigation link
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
        .tint(.primary)  // changed because now will be a navigation link
    }
}

struct SearchChildView: View {
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        Text("Child view is searching: \(isSearching.description)")
    }
}

#Preview {
    NavigationStack {
        SearchableBootcamp()
    }
}
