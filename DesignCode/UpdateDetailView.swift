//
//  UpdateDetailView.swift
//  DesignCode
//
//  Created by Tochi on 09/05/2020.
//  Copyright © 2020 martins. All rights reserved.
//

import SwiftUI

struct UpdateDetailView: View {
    var update: Update = updateData[0]
    var body: some View {
        List {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(update.title)
        }
    .listStyle(PlainListStyle())
    }
}

struct UpdateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetailView()
    }
}
