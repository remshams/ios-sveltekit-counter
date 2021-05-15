//
//  Footer.swift
//  sveltekit-counter
//
//  Created by Mathias Remshardt on 15.05.21.
//

import Foundation
import SwiftUI

struct Footer: View {
  var body: some View {
    HStack(spacing: 0) {
      Text("visit")
      Link(" kit.svelte.dev ", destination: URL(string: "https://kit.svelte.dev/")!).foregroundColor(.red)
      Text("to learn SvelteKit")
    }
  }
}

#if DEBUG
  struct Footer_Previews: PreviewProvider {
    static var previews: some View {
      Footer()
    }
  }
#endif
