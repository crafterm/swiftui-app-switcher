//
//  AppView.swift
//  App Switcher
//
//  Created by Marcus Crafter on 13/9/20.
//

import SwiftUI

// View representing an app page in the app switcher
struct AppView: View {
    var index: Int
    var app: AppSwitcherView.App
    var titleOpacity: Double

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AppMiniIconView(image: app.image, color: app.color)
                    .frame(width: 30, height: 30)

                Text(app.name)
                    .font(.callout)
                    .bold()
                    .foregroundColor(.white)
                    .opacity(titleOpacity)
            }
            .offset(x: 15)

            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(app.color)
                    .shadow(radius: 3)

                Image(systemName: app.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 260, height: 580)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(index: 1, app: AppSwitcherView.App(name: "Messages", image: "message.fill", color: .red), titleOpacity: 1)
    }
}
