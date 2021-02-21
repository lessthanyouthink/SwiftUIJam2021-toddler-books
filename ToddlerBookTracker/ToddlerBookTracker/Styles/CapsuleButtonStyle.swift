//
//  CapsuleButtonStyle.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-21.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label            
            .overlay(
                Capsule()
                    .stroke(lineWidth: 2)
            )
            .foregroundColor(.accentColor)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
