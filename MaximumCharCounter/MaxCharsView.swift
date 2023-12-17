//
//  MaxCharsView.swift
//  MaximumCharCounter
//
//  Created by Elliot Knight on 17/12/2023.
//

import SwiftUI

struct MaxCharsView: View {

    private let maximumChars: Int = 10

    @State private var userInput: String = ""
    @State private var value: Int = 0
    @State private var isOverMaximumValue: Int?

    @State private var tintColor: Color = .blue


    @FocusState private var keyboardFocus: Bool

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TextField("Write your thougts", text: $userInput)
                    .focused($keyboardFocus)
                Gauge(value: CGFloat(value), in: 0...CGFloat(maximumChars)) {
                    Text(isZeroOrMore)
                        .foregroundStyle(.red)
                }
                .tint(tintColor)
                .gaugeStyle(.accessoryCircularCapacity)
            }
        }
        .onChange(of: userInput) {
            calculRemainingCharacters(input: userInput, maximumCharacters: maximumChars)
        }
        .onAppear {
            keyboardFocus = true
        }
    }

    // MARK: Private methods

    /// Calculates the remaining characters and updates properties based on the input and maximum character count.
    /// - Parameters:
    ///   - input: The input string to evaluate the character count.
    ///   - maximumCharacters: The maximum allowed number of characters.
    private func calculRemainingCharacters(
        input: String,
        maximumCharacters: Int
    ) {
        if input.count < maximumCharacters {
            value = input.count
            tintColor = .blue
            isOverMaximumValue = nil
        } else if input.count == maximumCharacters {
            tintColor = .red
            value = maximumCharacters
            isOverMaximumValue = 0
        } else {
            isOverMaximumValue = input.count - maximumCharacters
        }
    }

    /// A computed property that represents the value of 'isOverMaximumValue' in a specific format.
    private var isZeroOrMore: String {
        guard let isOverMaximumValue else { return "" }
        return isOverMaximumValue == .zero ? "0" : "-\(isOverMaximumValue)"
    }
}

/// MARK: Preview

#Preview {
    MaxCharsView()
}

