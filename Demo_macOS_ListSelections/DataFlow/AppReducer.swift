//
//  AppReducer.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI
import ComposableArchitecture

// Mock
let ids = [UUID(), UUID(), UUID()]

struct AppReducer: ReducerProtocol {
    struct State: Equatable {
        var columnVisibility = NavigationSplitViewVisibility.automatic

        var sidebarState = SidebarReducer.State(ids: ids)
        var contentStates = IdentifiedArrayOf<ContentReducer.State>()
        var detailStates = IdentifiedArrayOf<DetailReducer.State>()

        init(
            columnVisibility: NavigationSplitViewVisibility = .automatic,
            sidebarState: SidebarReducer.State = .init(ids: ids),
            contentStates: IdentifiedArrayOf<ContentReducer.State>
                = .init(uniqueElements: ids.map(ContentReducer.State.init)),
            detailStates: IdentifiedArrayOf<DetailReducer.State>
                = .init(uniqueElements: ids.map(DetailReducer.State.init))
        ) {
            self.columnVisibility = columnVisibility
            self.sidebarState = sidebarState
            self.contentStates = contentStates
            self.detailStates = detailStates
        }
    }

    enum Action: Equatable {
        case setColumnVisibility(NavigationSplitViewVisibility)

        case sidebar(action: SidebarReducer.Action)
        case content(id: UUID, action: ContentReducer.Action)
        case detail(id: UUID, action: DetailReducer.Action)
    }

    var coreReducer: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .setColumnVisibility(let visibility):
                state.columnVisibility = visibility
                return .none

            case .sidebar, .content, .detail:
                return .none
            }
        }
    }

    var body: some ReducerProtocol<State, Action> {
        coreReducer
            .forEach(\.contentStates, action: /Action.content, ContentReducer.init)
            .forEach(\.detailStates, action: /Action.detail, DetailReducer.init)
        
        Scope(state: \.sidebarState, action: /Action.sidebar, SidebarReducer.init)
    }
}
