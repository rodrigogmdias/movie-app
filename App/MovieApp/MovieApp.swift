//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Rodrigo Dias on 03/07/25.
//

import SwiftUI
import BottomNavigator

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            BottomNavigatorConfigurator.configure()
        }
    }
}
