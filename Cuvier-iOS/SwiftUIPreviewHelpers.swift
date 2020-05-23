//
//  SwiftUIPreviewHelpers.swift
//  Cuvier-iOS
//
//  Created by Igor Camilo on 23.05.20.
//  Copyright © 2020 Igor Camilo. All rights reserved.
//

import SwiftUI
import UIKit

#if DEBUG

struct UIViewPreview<T: UIView>: UIViewRepresentable {
    let uiView: T

    init(_ uiView: T, configuration: ((T) -> Void)? = nil) {
        self.uiView = uiView
        configuration?(uiView)
    }

    func makeUIView(context: Context) -> T { uiView }

    func updateUIView(_ uiView: T, context: Context) {}
}

struct UIViewControllerPreview<T: UIViewController>: UIViewControllerRepresentable {
    let uiViewController: T

    init(_ uiViewController: T, configuration: ((T) -> Void)? = nil) {
        self.uiViewController = uiViewController
        configuration?(uiViewController)
    }

    func makeUIViewController(context: Context) -> T { uiViewController }

    func updateUIViewController(_ uiView: T, context: Context) {}
}

#endif
