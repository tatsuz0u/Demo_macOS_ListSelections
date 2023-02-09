//
//  ContentView.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import SwiftUI

struct ContentView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.automatic

    @State private var sidebarSelection: Int?
    @State private var contentSelections = Set<Int>()
    @State private var detailSelections = Set<Int>()

    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            sidebar: {
                List(selection: $sidebarSelection) {
                    ForEach(0...10, id: \.self) { index in
                        Text("Sidebar row \(index)")
                    }
                }
                .navigationTitle("Sidebar")
            },
            content: {
                List(selection: $contentSelections) {
                    ForEach(0...10, id: \.self) { index in
                        Text("Content row \(index)")
                    }
                }
                .navigationTitle("Content")
            },
            detail: {
                List(selection: $detailSelections) {
                    ForEach(0...100, id: \.self) { index in
                        Text("Detail row \(index)")
                    }
                }
                .navigationTitle("Detail")
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
