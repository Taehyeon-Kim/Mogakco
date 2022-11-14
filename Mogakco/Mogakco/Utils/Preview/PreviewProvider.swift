//
//  PreviewProvider.swift
//  Mogakco
//
//  Created by taekki on 2022/11/14.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    public func showPreview(_ deviceType: Device = .iPhone13Mini) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.rawValue))
    }
}

extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }

    public func showPreview(_ deviceType: Device = .iPhone13Mini) -> some View {
        Preview(view: self).previewDevice(PreviewDevice(rawValue: deviceType.rawValue))
    }
}
#endif

