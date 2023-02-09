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
            List(
                selection: viewStore.binding(
                    get: \.selections,
                    send: ContentReducer.Action.setSelections
                )
            ) {
                Section("Status") {
                    ForEach(ContentReducer.Status.allCases, id: \.self) { status in
                        NavigationLink(value: ContentReducer.Selection.status(status)) {
                            Text(status.rawValue.capitalized)
                        }
                    }
                }
                Section("Category") {
                    ForEach(ContentReducer.Category.allCases, id: \.self) { category in
                        NavigationLink(value: ContentReducer.Selection.category(category)) {
                            Text(category.rawValue.capitalized)
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
    let selections: Set<ContentReducer.Selection>

    init(state: ContentReducer.State) {
        self.id = state.id
        self.selections = state.selections
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
