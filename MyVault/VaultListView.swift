//
//  ContentView.swift
//  MyVault
//
//  Created by André Porto on 26/05/24.
//

import SwiftUI
import SwiftData

struct VaultListView: View {
    @Query(sort: \Vault.title) private var vaults: [Vault]
    @State private var createNewVault = false
    
    var body: some View {
        NavigationStack {
            Group {
                if vaults.isEmpty {
                    ContentUnavailableView("Adicione sua primeira moeda", systemImage: "dollarsign.circle.fill")
                } else {
                    List {
                        ForEach(vaults) { vault in
                            NavigationLink {
                                Text(vault.title)
                            } label: {
                                HStack(spacing: 10) {
                                    vault.icon
                                    VStack(alignment: .leading) {
                                        Text(vault.title).font(.title2)
                                        Text(vault.vaultnumber).foregroundStyle(.secondary)
                                        
                                        if let rating = vault.rating {
                                            HStack {
                                                ForEach(0..<rating, id: \.self) {
                                                    _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .onDelete { IndexSet in
                                IndexSet.ForEach { index in
                                    let vault = vaults[index]
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Vault")
            .toolbar {
                Button {
                    createNewVault = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewVault) {
                NewVaultView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    VaultListView()
        .modelContainer(for: Vault.self, inMemory: true)
}
