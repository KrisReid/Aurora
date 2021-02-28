//
//  ViewExtension.swift
//  Aurora
//
//  Created by Kris Reid on 27/02/2021.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
