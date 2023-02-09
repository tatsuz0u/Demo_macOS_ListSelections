//
//  RootView.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @StateObject var store: StoreOf<AppReducer>

    var body: some View {
        WithViewStore(store, observe: ViewState.init) { viewStore in
            NavigationSplitView(
                columnVisibility: viewStore.binding(
                    get: \.columnVisibility,
                    send: AppReducer.Action.setColumnVisibility
                ),
                sidebar: {
                    Sidebar(
                        store: store.scope(
                            state: \.sidebarState,
                            action: AppReducer.Action.sidebar
                        )
                    )
                },
                content: {
                    ZStack {
                        ForEachStore(
                            store.scope(
                                state: \.contentStates,
                                action: AppReducer.Action.content
                            )
                        ) { store in
                            ContentView(store: store, selectedID: viewStore.selectedID)
                        }
                    }
                },
                detail: {
                    ZStack {
                        ForEachStore(
                            store.scope(
                                state: \.detailStates,
                                action: AppReducer.Action.detail
                            )
                        ) { store in
                            DetailView(store: store, selectedID: viewStore.selectedID)
                        }
                    }
                }
            )
        }
    }
}

private struct ViewState: Equatable {
    let columnVisibility: NavigationSplitViewVisibility
    let selectedID: UUID?

    init(state: AppReducer.State) {
        self.columnVisibility = state.columnVisibility
        self.selectedID = state.sidebarState.selection
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: .init(
                initialState: .init(
                    columnVisibility: .all,
                    sidebarState: .init(
                        ids: ids,
                        selection: ids.first
                    )
                ),
                reducer: .empty
            )
        )
        .previewDisplayName("Selected")

        RootView(
            store: .init(
                initialState: .init(
                    columnVisibility: .all
                ),
                reducer: .empty
            )
        )
        .previewDisplayName("Not Selected")
    }
}
