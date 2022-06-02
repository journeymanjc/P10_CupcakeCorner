//
//  AddressView.swift
//  P10_CupcakeCorner
//
//  Created by Jae Cho on 5/30/22.
//

import SwiftUI

struct AddressView: View {
	@ObservedObject var cupcake: CupCake
	
    var body: some View {
		 Form{
			 Section{
				 TextField("Name", text: $cupcake.order.name)
				 TextField("Street Address", text: $cupcake.order.streetAddress)
				 TextField("City", text: $cupcake.order.city)
				 TextField("Zipcode", text: $cupcake.order.zip)
			 }
			 
			 Section{
				 NavigationLink{
					 CheckoutView(cupcake: cupcake)
				 } label: {
					 Text("Check out")
				 }
			 }
			 .disabled(cupcake.order.hasValidAddress == false)
		 }
		 .navigationTitle("Delivery details")
		 .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
		 AddressView(cupcake: CupCake())
    }
}
