//
//  Vault.swift
//  MyVault
//
//  Created by André Porto on 26/05/24.
//

import SwiftUI
import SwiftData

@Model
class Vault {
    var title: String
    var vaultnumber: String
    var buyDate: Date
    var summary: String
    var rating: Int?
    var status: Status
    
    init(
        title: String,
        vaultnumber: String,
        buyDate: Date = Date.now,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .buyed
    ) {
        self.title = title
        self.vaultnumber = vaultnumber
        self.buyDate = buyDate
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    var icon: Image {
        switch status {
        case .buyed:
            Image(systemName: "dollarsign.circle.fill")
        case .interested:
            Image(systemName: "eye.circle.fill")
        case .solded:
            Image(systemName: "dollarsign.arrow.circlepath")
        }
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case buyed, interested, solded
    var id: Self {
        self
    }
    var description: String {
        switch self {
        case .buyed:
            "Comprado"
        case .interested:
            "Interessado"
        case .solded:
            "Vendido"
        }
    }
}
