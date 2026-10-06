//
//  QuizView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 10/2/26.
//

import SwiftUI

struct QuizView: View {
    var currword: VocabWord
    var isFront: Bool = true
    
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity)
        .background(.bg)
    }
}

#Preview {
    QuizView(currword: exampleWord)
}
