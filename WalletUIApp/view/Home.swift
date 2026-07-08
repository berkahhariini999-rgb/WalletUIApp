//
//  Home.swift
//  WalletUIApp
//
//  Created by Iqbal Alhadad on 08/07/26.
//

import SwiftUI

struct Home: View {
    @State private var selectedCardID: String?
    @State private var info: Info = .init()
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: -150) {
                    ForEach(cards) {
                        card in
                        CardView(card)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .safeAreaPadding(15)
            .navigationTitle(isNavigationTitleHidden ? "" : "Wallet")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    if isCardSelected {
                        Button("Close", systemImage: "xmark") {
                            withAnimation(animation) {
                                selectedCardID = nil
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isCardSelected ? "Edit" : "Add Card", systemImage: isCardSelected ? "creditcard.and.numbers" : "plus") {
                        
                    }
                    
                }
                
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Search", systemImage: "magnifyingglass") {
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Options", systemImage: "ellipsis") {
                        
                    }
                }
            }
            .onScrollGeometryChange(for: CGFloat.self) {
                $0.contentOffset.y + $0.contentInsets.top
            } action: { oldValue, newValue in
                info.scrollOffset = newValue
            }
        }
        .onGeometryChange(for: CGSize.self) {
            $0.size
        } action: { newValue in
            info.containerSize = newValue
        }
        
        .onGeometryChange(for: EdgeInsets.self) {
            $0.safeAreaInsets
        } action: { newValue in
            info.safeArea = newValue
        }
        
        
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        Rectangle()
            .foregroundStyle(.clear)
            .overlay {
                Image(card.cardBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .overlay {
                VStack {
                    HStack {
                        Text(card.cardCategory)
                            .monospaced()
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        Spacer (minLength: 0)
                        
                        Image(card.cardType)
                            .resizable()
                            .renderingMode(card.cardType == "MC" ? .original : .template)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                           
                    }
                    
                    .foregroundStyle(.white)
                    
                    Spacer(minLength: 0)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(card.title)
                            .monospaced()
                        
                        Text("**** 1234")
                            .monospaced()
                    }
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
            }
            .clipShape(.rect(cornerRadius: 20))
            .frame(height: 220)
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(animation) {
                    selectedCardID = card.id
                    
                }
            }
    }
    
    var isNavigationTitleHidden: Bool {
        return info.scrollOffset > 1 || isCardSelected
    }
    
    var isCardSelected: Bool {
        return selectedCardID != nil
    }
    
    struct Info {
        var scrollOffset: CGFloat = 0
        var containerSize: CGSize = .zero
        var safeArea: EdgeInsets = .init()
    }
    
    var animation: Animation = .interactiveSpring(response: 0.55, dampingFraction: 0.8)
    
}

#Preview {
    Home()
}
