//
//  Header.swift
//  sveltekit-counter
//
//  Created by Mathias Remshardt on 13.05.21.
//

import Foundation
import SwiftUI

struct Header: View {
  var body: some View {
    VStack {
      Image("svelte-welcome")
        .resizable()
        .scaledToFit()
      Text("to your new").font(.system(size: 30))
      Text("SvelteKit iOS App").font(.system(size: 30))
    }
  }
}

#if DEBUG
struct Header_Previews: PreviewProvider {
  static var previews: some View {
    Header()
  }
}
#endif
