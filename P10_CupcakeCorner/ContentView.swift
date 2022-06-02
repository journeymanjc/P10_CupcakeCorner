//
//  ContentView.swift
//  P10_CupcakeCorner
//
//  Created by Jae Cho on 5/28/22.
//

import SwiftUI




struct ContentView: View {
	@StateObject var cupcake = CupCake()
		
    var body: some View {
		 NavigationView{
			 Form{
				 Section{
					 Picker("Select your cake type", selection: $cupcake.order.type){
						 ForEach(Order.types.indices){
							 Text(Order.types[$0])
						 }
					 }
					 Stepper("Number of cakes: \(cupcake.order.quantity)", value: $cupcake.order.quantity, in: 3...20)
				 }
				 Section{
					 Toggle("Any special requests?", isOn: $cupcake.order.specialRequestEnabled.animation())
					 
					 if cupcake.order.specialRequestEnabled {
						 Toggle("Add extra frosting", isOn: $cupcake.order.extraFrosting)
						 Toggle("Add extra sprinkles", isOn: $cupcake.order.addSprinkles)
					 }
				 }
				 Section{
					 NavigationLink{
						 AddressView(cupcake: cupcake)
					 } label :{
						 Text("Detail Details")
					 }
				 }
			 }
			 .navigationTitle("Cupcake Corner")
		 }
	 }
	

	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
