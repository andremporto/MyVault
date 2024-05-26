//
//  NewVaultView.swift
//  MyVault
//
//  Created by André Porto on 26/05/24.
//

import SwiftUI

struct NewVaultView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var vaultnumber = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Criptomoeda", text: $title)
                TextField("Blockchain number", text: $vaultnumber)
                Button("Adicionar") {
                    let newVault = Vault(title: title, vaultnumber: vaultnumber)
                    context.insert(newVault)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || vaultnumber.isEmpty)
                .navigationTitle("Adicionar moeda")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancelar") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewVaultView()
}
