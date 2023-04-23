//
//  EmptyListView.swift
//  Todo
//
//  Created by seungchul lee on 2023/04/23.
//

import SwiftUI

struct EmptyListView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("illustration-no1")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 250, idealWidth: 280, maxWidth: 320, minHeight: 250, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .layoutPriority(1)
                Text("use your time wisely")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded, weight: .medium))
            }
            .padding(.horizontal)
        }
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Preview: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .environment(\.colorScheme, .dark)
    }
}
