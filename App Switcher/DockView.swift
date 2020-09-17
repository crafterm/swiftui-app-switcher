//
//  DockView.swift
//  App Switcher
//
//  Created by Marcus Crafter on 9/9/20.
//

import SwiftUI

/// Dock view containing 4 app icons
struct DockView: View {
    var appCount = 4

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        HStack {
            LazyVGrid(columns: columns, alignment: .center) {
                ForEach(1...appCount, id: \.self) { item in
                    AppIconView()
                        .padding(.vertical, 16)
                }
            }
            .padding(.horizontal, 6)
            .background(Color(white: 1.0, opacity: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
        .padding(.horizontal, 12)
    }
}

struct DockView_Previews: PreviewProvider {
    static var previews: some View {
        DockView()
            .background(Color.gray)
    }
}
