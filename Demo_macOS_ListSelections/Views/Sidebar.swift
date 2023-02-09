//
//  Sidebar.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI
import ComposableArchitecture

struct Sidebar: View {
    let store: StoreOf<SidebarReducer>

    var body: some View {
        WithViewStore(store, observe: ViewState.init) { viewStore in
            List(
                selection: viewStore.binding(
                    get: \.selection,
                    send: SidebarReducer.Action.setSelection
                )
            ) {
                ForEach(viewStore.ids, id: \.self) { id in
                    Text("Sidebar row \(id.uuidString))")
                }
            }
            .navigationTitle("Sidebar")
        }
    }
}

private struct ViewState: Equatable {
    let ids: [UUID]
    let selection: UUID?

    init(state: SidebarReducer.State) {
        self.ids = state.ids
        self.selection = state.selection
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(
            store: .init(
                initialState: .init(ids: ids),
                reducer: .empty
            )
        )
    }
}
