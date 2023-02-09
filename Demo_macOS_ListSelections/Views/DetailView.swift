//
//  DetailView.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI
import ComposableArchitecture

struct DetailView: View {
    let store: StoreOf<DetailReducer>
    let selectedID: UUID?

    var body: some View {
        WithViewStore(store, observe: ViewState.init) { viewStore in
            List(
                selection: viewStore.binding(
                    get: \.selections,
                    send: DetailReducer.Action.setSelections
                )
            ) {
                ForEach(0...100, id: \.self) { index in
                    Text("Detail row \(index)")
                }
            }
            .opacity(viewStore.id == selectedID ? 1 : 0)
            .navigationTitle("Detail")
        }
    }
}

private struct ViewState: Equatable {
    let id: UUID
    let selections: Set<Int>

    init(state: DetailReducer.State) {
        self.id = state.id
        self.selections = state.selections
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedID = UUID()

        DetailView(
            store: .init(
                initialState: .init(id: selectedID),
                reducer: .empty
            ),
            selectedID: selectedID
        )
        .previewDisplayName("Selected")

        DetailView(
            store: .init(
                initialState: .init(id: selectedID),
                reducer: .empty
            ),
            selectedID: nil
        )
        .previewDisplayName("Not Selected")
    }
}
