//
//  AppMiniIcon.swift
//  App Switcher
//
//  Created by Marcus Crafter on 13/9/20.
//

import SwiftUI

// App mini icon, shown above the app view
struct AppMiniIconView: View {
    var image: String
    var color: Color

    var body: some View {
        GeometryReader { value in
            ZStack {
                color

                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.all, value.frame(in: .global).width * 0.18)
                    .foregroundColor(.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .overlay(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.white.opacity(0.5),
                            Color.clear
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(radius: 3)
        }
    }
}

struct AppMiniIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppMiniIconView(image: "message.fill", color: .green)
                .frame(width: 100, height: 100)
                .background(Color.red)

            AppMiniIconView(image: "message.fill", color: .green)
                .frame(width: 30, height: 30)
                .background(Color.red)
        }
    }
}
