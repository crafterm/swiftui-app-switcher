//
//  AppSwitcherView.swift
//  App Switcher
//
//  Created by Marcus Crafter on 13/9/20.
//

import SwiftUI

struct AppSwitcherView: View {
    struct App: Identifiable {
        var id = UUID()
        var name: String
        var image: String
        var color: Color
    }

    let apps = [
        App(name: "Messages", image: "message.fill", color: .green),
        App(name: "Watch", image: "applewatch", color: .black),
        App(name: "FaceTime", image: "video.fill", color: .green),
        App(name: "Apple", image: "applelogo", color: .blue),
        App(name: "Camera", image: "camera", color: .gray),
        App(name: "Phone", image: "phone.fill", color: .green),
        App(name: "TV", image: "appletv", color: .black),
    ]

    var viewState: HomeScreen.ViewState
    var dragX: CGFloat

    var body: some View {
        ZStack {
            ForEach(apps.indices.reversed(), id: \.self) { index in
                AppView(index: index, app: apps[index], titleOpacity: titleOpacity(for: index))
                    .offset(x: offset(for: index))
                    .scaleEffect(switcherEnabledScale(for: index))
            }

//            VStack {
//                Spacer()
//
//                Text("\(dragX) - \(switcherEnabledOffset(for: 1))")
//            }
        }
        .animation(.linear)
    }

    private func offset(for index: Int) -> CGFloat {
        switch viewState {
        case .apps:
            return 0
        case .blurred:
            return blurEnabledOffset(for: index)
        case .switcherEnabled:
            return switcherEnabledOffset(for: index)
        }
    }

    private let openingPanOffset: CGFloat = 200 // ensures app views are initially spread out
    private let openingAlignmentOffset: CGFloat = 80 // pushes switcher to the left a little due to above
    private let appViewSpacing: CGFloat = 50 // spaces the app views out so that they cycle when panned

    private func switcherEnabledOffset(for index: Int) -> CGFloat {
        curveX(dragX + openingPanOffset - CGFloat(index + 1) * appViewSpacing) - openingAlignmentOffset
    }

    private let blurAppViewSpacing: CGFloat = 20 // spacing between app views when in blurred mode, ie side by side

    private func blurEnabledOffset(for index: Int) -> CGFloat {
        return dragX - (CGFloat(index) * (260 + blurAppViewSpacing))
    }

    private let scaleBandingFactor: CGFloat  = 2000 // softens the scaling reduction to gradually decrease in size

    private func switcherEnabledScale(for index: Int) -> CGFloat {
        let offset = switcherEnabledOffset(for: index)

        if offset > 0 {
            return 1
        }

        return max(0.94, (1 - abs(offset) / scaleBandingFactor))
    }

    private func titleOpacity(for index: Int) -> Double {
        if viewState == .blurred {
            return 1
        }

        let offset = switcherEnabledOffset(for: index)

        if offset > -50 && offset < 180 {
            return 1
        }

        return 0
    }

    private let curveDampingFactor: CGFloat = 20 // settles the power function down a little

    private func curveX(_ inputX: CGFloat) -> CGFloat {
        pow(1.8, inputX / curveDampingFactor)
    }
}

struct AppSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        AppSwitcherView(viewState: .switcherEnabled, dragX: 0)
    }
}
