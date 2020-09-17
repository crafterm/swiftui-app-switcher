//
//  AppIconGridView.swift
//  App Switcher
//
//  Created by Marcus Crafter on 14/9/20.
//

import SwiftUI

// App icon grid view to layout some example app icons
struct AppIconGridView: View {
    var appCount = 24

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center) {
            ForEach(1...appCount, id: \.self) { item in
                AppIconView(
                    title: "App \(item)",
                    badgeNumber: item == 14 ? 3 : nil
                )
                .padding(.bottom, 12)
            }
        }
        .padding(.horizontal)
    }
}

struct AppIconGridView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconGridView()
    }
}
