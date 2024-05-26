//
//  MyVaultApp.swift
//  MyVault
//
//  Created by André Porto on 26/05/24.
//

import SwiftUI
import SwiftData

@main
struct MyVaultApp: App {
    var body: some Scene {
        WindowGroup {
            VaultListView()
        }
        .modelContainer(for: Vault.self)
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
