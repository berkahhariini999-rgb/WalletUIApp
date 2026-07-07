//
//  Card.swift
//  WalletUIApp
//
//  Created by Iqbal Alhadad on 07/07/26.
//

import SwiftUI

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var cardBackground: String
    var title: String
    var cardCategory: String
    var cardType: String
    
    //dummy mock data
    let cards: [Card] = [
        .init(cardBackground: "Card 1", title: "Grace", cardCategory: "DEBIT", cardType: "Visa")
    ]
}
