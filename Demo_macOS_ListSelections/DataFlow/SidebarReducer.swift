//
//  SidebarReducer.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import Foundation
import ComposableArchitecture

struct SidebarReducer: ReducerProtocol {
    struct State: Equatable {
        let ids: [UUID]
        var selection: UUID?
    }

    enum Action: Equatable {
        case setSelection(UUID?)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .setSelection(let selection):
                state.selection = selection
                return .none
            }
        }
    }
}
