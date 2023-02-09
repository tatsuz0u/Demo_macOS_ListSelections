//
//  ContentReducer.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import Foundation
import ComposableArchitecture

struct ContentReducer: ReducerProtocol {
    enum Status: String, Equatable, CaseIterable {
        case a, b, c
    }
    enum Category: String, Equatable, CaseIterable {
        case x, y, z
    }

    enum Selection: Equatable, Hashable {
        case status(Status)
        case category(Category)
    }

    struct State: Equatable, Identifiable {
        let id: UUID

        var selectedStatus: Status?
        var selectedCategory: Category?

        init(id: UUID) {
            self.id = id
        }
    }

    enum Action: Equatable {
        case selectStatus(Status?)
        case selectCategory(Category?)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .selectStatus(let status):
                state.selectedStatus = status
                return .none

            case .selectCategory(let category):
                state.selectedCategory = category
                return .none
            }
        }
    }
}
