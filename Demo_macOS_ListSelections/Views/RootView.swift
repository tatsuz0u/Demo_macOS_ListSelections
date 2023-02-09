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
                    List(
                        selection: viewStore.binding(
                            get: \.sidebarSelection,
                            send: AppReducer.Action.setSidebarSelection
                        )
                    ) {
                        ForEach(0...10, id: \.self) { index in
                            Text("Sidebar row \(index)")
                        }
                    }
                    .navigationTitle("Sidebar")
                },
                content: {
                    List(
                        selection: viewStore.binding(
                            get: \.contentSelections,
                            send: AppReducer.Action.setContentSelections
                        )
                    ) {
                        ForEach(0...10, id: \.self) { index in
                            Text("Content row \(index)")
                        }
                    }
                    .navigationTitle("Content")
                },
                detail: {
                    List(
                        selection: viewStore.binding(
                            get: \.detailSelections,
                            send: AppReducer.Action.setDetailSelections
                        )
                    ) {
                        ForEach(0...100, id: \.self) { index in
                            Text("Detail row \(index)")
                        }
                    }
                    .navigationTitle("Detail")
                }
            )
        }
    }
}

private struct ViewState: Equatable {
    let columnVisibility: NavigationSplitViewVisibility
    let sidebarSelection: Int?
    let contentSelections: Set<Int>
    let detailSelections: Set<Int>

    init(state: AppReducer.State) {
        self.columnVisibility = state.columnVisibility
        self.sidebarSelection = state.sidebarSelection
        self.contentSelections = state.contentSelections
        self.detailSelections = state.detailSelections
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: .init(initialState: .init(), reducer: AppReducer()))
    }
}
