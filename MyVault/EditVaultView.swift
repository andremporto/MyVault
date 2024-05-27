//
//  EditVaultView.swift
//  MyVault
//
//  Created by André Porto on 26/05/24.
//

import SwiftUI

struct EditVaultView: View {
    @Environment(\.dismiss) private var dismiss
    let valt: Vault
    @State private var status = Status.buyed
    @State private var rating: Int?
    @State private var title = ""
    @State private var vaultnumber = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.description).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .interested || status == .solded {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .solded {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if !firstView {
                    if newValue == .onShelf {
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .completed {
                        // from completed to inProgress
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        // Book has been started
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .onShelf {
                        // Forgot to start book
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        // completed
                        dateCompleted = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            } label: {
                Text("Rating")
            }
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $vaultnumber)
            } label: {
                Text("Author").foregroundStyle(.secondary)
            }
            Divider()
            Text("Summary").foregroundStyle(.secondary)
            TextEditor(text: $summary)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    valt.status = status
                    valt.rating = rating
                    valt.title = title
                    valt.vaultnumber = vaultnumber
                    valt.summary = summary
                    valt.buyDate = dateAdded
                    valt.dateStarted = dateStarted
                    valt.dateCompleted = dateCompleted
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            status = valt.status
            rating = valt.rating
            title = valt.title
            vaultnumber = valt.vaultnumber
            summary = valt.summary
            dateAdded = valt.buyDate
            dateStarted = valt.buyDate
            dateCompleted = valt.dateCompleted
        }
    }
    
    var changed: Bool {
        status != valt.status
        || rating != valt.rating
        || title != valt.title
        || vaultnumber != valt.vaultnumber
        || summary != valt.summary
        || dateAdded != valt.buyDate
        || dateStarted != valt.buyDate
        || dateCompleted != valt.solded
    }
}

#Preview {
    NavigationStack {
        EditVaultView()
    }
}
