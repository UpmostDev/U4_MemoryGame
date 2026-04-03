//
//  ContentView.swift
//  U4_MemoryGame
//
//  Created by Jordyn on 01/04/2026.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let emoji: String
    var isFaceUp = false
    var isMatched = false
}

struct ContentView: View {

    let allEmojis = ["🍎", "🐶", "🌟", "🚀", "🎸", "🌈", "🍕", "🎯", "🐱", "🌺"]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @State private var cards: [Card] = []
    @State private var firstSelectedIndex: Int? = nil
    @State private var numberOfPairs: Int = 3

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Menu {
                    Button("3 Pairs") { updatePairs(3) }
                    Button("6 Pairs") { updatePairs(6) }
                    Button("10 Pairs") { updatePairs(10) }
                } label: {
                    Text("Choose Size")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.orange)
                        .cornerRadius(20)
                }

                Spacer()

                Button(action: resetGame) {
                    Text("Reset Game")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                        cardView(for: card)
                            .onTapGesture {
                                cardTapped(index: index)
                            }
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.top)
        .onAppear {
            cards = createCards(pairs: numberOfPairs)
        }
    }

    // MARK: - Card View

    @ViewBuilder
    func cardView(for card: Card) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2)
                Text(card.emoji)
                    .font(.system(size: 40))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue)
            }
        }
        .frame(height: 120)
        .opacity(card.isMatched ? 0 : 1)
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
    }

    // MARK: - Game Logic

    func cardTapped(index: Int) {
        let faceUpCount = cards.filter { $0.isFaceUp && !$0.isMatched }.count
        if faceUpCount >= 2 { return }

        if cards[index].isFaceUp || cards[index].isMatched { return }
        if index == firstSelectedIndex { return }

        withAnimation(.easeInOut(duration: 0.3)) {
            cards[index].isFaceUp = true
        }

        if let firstIndex = firstSelectedIndex {
            if cards[firstIndex].emoji == cards[index].emoji {
                let matchedFirst = firstIndex
                let matchedSecond = index
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        cards[matchedFirst].isMatched = true
                        cards[matchedSecond].isMatched = true
                    }
                }
            } else {
                let unmatchedFirst = firstIndex
                let unmatchedSecond = index
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        cards[unmatchedFirst].isFaceUp = false
                        cards[unmatchedSecond].isFaceUp = false
                    }
                }
            }
            firstSelectedIndex = nil
        } else {
            firstSelectedIndex = index
        }
    }

    func createCards(pairs: Int) -> [Card] {
        let selected = Array(allEmojis.prefix(pairs))
        var deck: [Card] = []
        for emoji in selected {
            deck.append(Card(emoji: emoji))
            deck.append(Card(emoji: emoji))
        }
        return deck.shuffled()
    }

    func resetGame() {
        withAnimation {
            cards = createCards(pairs: numberOfPairs)
            firstSelectedIndex = nil
        }
    }

    func updatePairs(_ count: Int) {
        numberOfPairs = count
        resetGame()
    }
}

#Preview {
    ContentView()
}
