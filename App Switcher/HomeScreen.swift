//
//  HomeScreen.swift
//  App Switcher
//
//  Created by Marcus Crafter on 9/9/20.
//

import SwiftUI

/// Primary container view of the apps, and switcher.
struct HomeScreen: View {

    /// Interaction state
    enum ViewState: Comparable {
        case apps // showing apps on the home screen
        case blurred // blurred apps, with app switcher in side/side layout
        case switcherEnabled // switcher enabled with sliding reveal animation
    }

    // amount to drag the screen vertically to engage the switcher
    private let switcherDragThreshold: CGFloat = 80

    @GestureState private var dragState = CGSize.zero
    @State private var viewState: ViewState = .apps
    @State private var dragEndX: CGFloat = 0

    var body: some View {
        ZStack {
            ZStack(alignment: .center) {
                BackgroundView()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

                VStack {
                    AppIconGridView()
                        .padding(.top, 50)

                    Spacer()
                    
                    DockView()
                        .padding(.bottom, 12)
                }
                .scaleEffect(scaleValue)

            }
            .edgesIgnoringSafeArea(.all)
            .blur(radius: blurValue)
            .animation(.easeOut)

            if viewState >= .blurred {
                Color.black.opacity(0.01)
                    .onTapGesture {
                        self.viewState = .apps
                        self.dragEndX = 0
                    }
            }

            AppSwitcherView(viewState: viewState, dragX: dragState.width + dragEndX)
                .offset(x: switcherOffsetX)
                .scaleEffect(switcherScale)
                .animation(.easeInOut)
        }
        .gesture(
            DragGesture()
                .updating($dragState) { value, state, transaction in
                    state = value.translation

                    // 20% under to trigger a pull effect
                    let threshold = switcherDragThreshold * 0.80

                    if self.viewState == .apps && value.translation.height < -threshold {
                        DispatchQueue.main.async {
                            self.viewState = .blurred
                        }
                    }
                }
                .onEnded { value in
                    if self.viewState == .switcherEnabled {
                        self.dragEndX += value.translation.width
                    } else {
                        self.dragEndX = 0
                    }

                    if self.viewState >= .blurred {
                        self.viewState = .switcherEnabled
                    } else {
                        self.viewState = .apps
                    }
                }
        )
    }

    /// Positions the app switcher based on interaction.
    /// When fully enabled its centered, blurred its slightly exposed
    /// to the left, and when apps are shown its animated offscreen
    private var switcherOffsetX: CGFloat {
        switch viewState {
        case .switcherEnabled:
            return 0
        case .blurred:
            return -300 + dragState.width
        case .apps:
            return -500
        }
    }

    /// Scales the switcher based on interaction.
    /// When in blurred mode height changes scale the app switcher down
    /// to 70% while dragging
    private var switcherScale: CGFloat {
        switch viewState {
        case .switcherEnabled:
            return 1
        case .blurred:
            return max(0.7, 1 - abs(dragState.height) / 580)
        case .apps:
            return 1
        }
    }

    /// Amount to blur the background and app icons by when the switcher
    /// is engaged.
    private var blurValue: CGFloat {
        if viewState >= .blurred {
            return 12
        }

        return 0
    }

    /// Amount to scale the background and app icons by while initially
    /// dragging, and to remain at once the switcher is engaged.
    private var scaleValue: CGFloat {
        let height = dragState.height

        if viewState >= .blurred {
            return 1 - switcherDragThreshold / 1000
        }

        if height >= 0 {
            return 1
        }

        return 1 - abs(height) / 1000
    }
}

/// Placeholder background view
struct BackgroundView: View {
    var body: some View {
        Image("desktop")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
