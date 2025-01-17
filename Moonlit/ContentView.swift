//
//  ContentView.swift
//  Moonlit
//
//  Created by minjune Song on 3/20/24.
//

import Foundation
import SwiftUI
import Photos
import Auth

enum PickMode {
    case auto
    case manual
    case none
}

struct ContentView: View {
    let id : UUID
    @State private var pageIndex = 0
    @State private var pickMode: PickMode = .auto
    @State private var displayPicker : Bool = true
    @Environment(\.displayScale) private var displayScale
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()

    var body: some View {
            NavigationView {
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        VStack {
                            Spacer()
                            PageView(page: page)
                            Spacer()
                            if page == pages.last {
                                NavigationLink(destination: GalleryView(pickMode: pickMode, displayPicker: $displayPicker, id: id)) {
                                    Text("Select Photos")
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    if pickMode == .manual {
                                        print("firing")
                                        displayPicker = true
                                    } else {
                                        displayPicker = false
                                    }
                                })
                                .buttonStyle(.bordered)
                                .onAppear {
                                    requestAccess()
                                }
                            } else {
                                Button("next", action: incrementPage)
                                    .buttonStyle(.borderedProminent)
                            }
                            Spacer()
                        }
                        .tag(page.tag)
                    }
                }
                .animation(.easeInOut, value: pageIndex)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(PageTabViewStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: TutorialView()) {
                            Text("How to Use")
                        }
                    }
                }
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = .black
                    dotAppearance.pageIndicatorTintColor = .gray
                }
            }
        }
    
    func requestAccess() {
        // Request read-write access to the user's photo library
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                // The user hasn't determined this app's access.
                pickMode = .none
            case .restricted:
                // The system restricted this app's access.
                pickMode = .none
            case .denied:
                // The user explicitly denied this app's access.
                pickMode = .none
            case .authorized:
                // The user authorized this app to access Photos data.
                pickMode = .auto
            case .limited:
                // The user authorized this app for limited Photos access.
                pickMode = .manual
            @unknown default:
                fatalError()
            }
        }
    }
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

struct PickerView: View {
    let pickMode: PickMode
    
    var body: some View {
        // Your PickerView implementation goes here
        Text("PickerView")
            .font(.title)
        Text("Pick Mode: \(pickMode == .auto ? "Auto" : "Manual")")
    }
}
