//
//  AppReducer.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI
import ComposableArchitecture

struct AppReducer: ReducerProtocol {
    struct State: Equatable {
        var columnVisibility = NavigationSplitViewVisibility.automatic

        var sidebarSelection: Int?
        var contentSelections = Set<Int>()
        var detailSelections = Set<Int>()
    }

    enum Action: Equatable {
        case setColumnVisibility(NavigationSplitViewVisibility)
        case setSidebarSelection(Int?)
        case setContentSelections(Set<Int>)
        case setDetailSelections(Set<Int>)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .setColumnVisibility(let visibility):
                state.columnVisibility = visibility
                return .none
                
            case .setSidebarSelection(let selection):
                state.sidebarSelection = selection
                return .none

            case .setContentSelections(let selections):
                state.contentSelections = selections
                return .none

            case .setDetailSelections(let selections):
                state.detailSelections = selections
                return .none
            }
        }
    }
}
