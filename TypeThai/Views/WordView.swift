//
//  WordView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//
import SwiftUI

struct WordView: View {
    let currword = VocabWord(thai: "ฉัน",pronunciation: "chan", english: "I / Me",type:"Letter")
    var body: some View {
        VStack{
            HStack{
                Text(currword.thai)
                    .font(.system(size:70,weight: .bold))
            }
        }
        .frame(width: 350, height: 300)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 2)
        }
        
    }
}

#Preview {
    WordView()
}
