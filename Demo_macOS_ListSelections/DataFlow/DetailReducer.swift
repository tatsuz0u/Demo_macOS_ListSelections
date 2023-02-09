//
//  DetailReducer.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import Foundation
import ComposableArchitecture

struct DetailReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id: UUID
        var selections = Set<Int>()

        init(id: UUID) {
            self.id = id
        }
    }

    enum Action: Equatable {
        case setSelections(Set<Int>)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .setSelections(let selections):
                state.selections = selections
                return .none
            }
        }
    }
}
