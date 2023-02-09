//
//  ContentView.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<ContentReducer>
    let selectedID: UUID?

    var body: some View {
        WithViewStore(store, observe: ViewState.init) { viewStore in
            VStack(spacing: 0) {
                List(
                    selection: viewStore.binding(
                        get: \.selectedStatus,
                        send: ContentReducer.Action.selectStatus
                    )
                ) {
                    Section("Status") {
                        ForEach(ContentReducer.Status.allCases, id: \.self) { status in
                            NavigationLink(value: ContentReducer.Selection.status(status)) {
                                Text(status.rawValue.capitalized)
                            }
                        }
                    }
                }

                List(
                    selection: viewStore.binding(
                        get: \.selectedCategory,
                        send: ContentReducer.Action.selectCategory
                    )
                ) {
                    Section("Category") {
                        ForEach(ContentReducer.Category.allCases, id: \.self) { category in
                            NavigationLink(value: ContentReducer.Selection.category(category)) {
                                Text(category.rawValue.capitalized)
                            }
                        }
                    }
                }
            }
            .opacity(viewStore.id == selectedID ? 1 : 0)
            .navigationTitle("Content")
        }
    }
}

private struct ViewState: Equatable {
    let id: UUID
    let selectedStatus: ContentReducer.Status?
    let selectedCategory: ContentReducer.Category?

    init(state: ContentReducer.State) {
        self.id = state.id
        self.selectedStatus = state.selectedStatus
        self.selectedCategory = state.selectedCategory
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedID = UUID()

        ContentView(
            store: .init(
                initialState: .init(id: selectedID),
                reducer: .empty
            ),
            selectedID: selectedID
        )
        .previewDisplayName("Selected")

        ContentView(
            store: .init(
                initialState: .init(id: selectedID),
                reducer: .empty
            ),
            selectedID: .init()
        )
        .previewDisplayName("Not Selected")
    }
}
