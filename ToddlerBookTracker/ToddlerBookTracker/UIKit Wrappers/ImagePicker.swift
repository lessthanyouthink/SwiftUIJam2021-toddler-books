//
//  ImagePicker.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-20.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.allowsEditing = false
        controller.delegate = context.coordinator
        return controller
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // MARK: -

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = (info[.editedImage] ?? info[.originalImage]) as? UIImage
            parent.isPresented = false
        }
    }
}
