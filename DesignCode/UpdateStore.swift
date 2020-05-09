//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Tochi on 09/05/2020.
//  Copyright © 2020 martins. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
