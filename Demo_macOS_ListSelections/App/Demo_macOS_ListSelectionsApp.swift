//
//  Demo_macOS_ListSelectionsApp.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI

@main
struct Demo_macOS_ListSelectionsApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(initialState: .init(), reducer: AppReducer()))
        }
    }
}
