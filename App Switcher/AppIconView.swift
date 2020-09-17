//
//  AppIconView.swift
//  App Switcher
//
//  Created by Marcus Crafter on 9/9/20.
//

import SwiftUI

/// Home screen app icon view with badge support
struct AppIconView: View {
    var title: String?
    var badgeNumber: Int?

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(Color(white: 0.1, opacity: 0.5))

                if let number = badgeNumber {
                    VStack {
                        HStack {
                            Spacer()

                            Badge(number: number)
                                .offset(x: 10.0, y: -10.0)
                        }

                        Spacer()
                    }
                }

                Image(systemName: "applelogo")
                    .font(.title)
                    .offset(y: -2) // looks a little low
            }
            .frame(width: 62, height: 62)

            if let title = title {
                Text(title)
                    .font(.caption)
            }
        }
        .foregroundColor(.white)
    }
}

struct Badge: View {
    var number: Int

    var body: some View {
        Text("\(number)")
            .font(.callout)
            .minimumScaleFactor(0.5)
            .frame(width: 25, height: 25)
            .background(Color.red)
            .clipShape(Circle())
    }
}

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView(title: "App", badgeNumber: 2)
    }
}
