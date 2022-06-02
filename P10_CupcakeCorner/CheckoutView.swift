//
//  CheckoutView.swift
//  P10_CupcakeCorner
//
//  Created by Jae Cho on 5/30/22.
//

import SwiftUI

struct CheckoutView: View {
	@ObservedObject var cupcake : CupCake
	@State private var confirmationMessage = ""
	@State private var alertMessage = ""
	@State private var showingConfirmation = false
	
	var body: some View {
		ScrollView{
			VStack{
				AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
					image
						.resizable()
						.scaledToFit()
				} placeholder: {
					ProgressView()
				}
				.frame(height: 233)
				Text("Your total is \(cupcake.order.cost, format: .currency(code: "USD"))")
					.font(.title)
				Button("Place Order", action: {
					Task {   await placeOrder()    }
				})
				.padding()
			}
		}
		.navigationTitle("Check out")
		.navigationBarTitleDisplayMode(.inline)
		.alert(alertMessage, isPresented: $showingConfirmation) {
			Button("OK") {}
		} message: {
			Text(confirmationMessage)
		}
    }
	
	func placeOrder() async{
		guard let encoded = try? JSONEncoder().encode(cupcake.order) else {
			print("Failed to encode order")
			return
		}
		let url = URL(string: "https://reqres.in/api/cupcakes")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		do {
			let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
			//Handle the result
			let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
			alertMessage = "Thank you!"
			confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
			showingConfirmation = true
		} catch {
			print("Checkout failed.")
			//Challenge 52-2
			alertMessage = "Something went wrong!"
			confirmationMessage = "Request failed, Internet might be off."
			showingConfirmation = true
		}
	}
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(cupcake: CupCake())
    }
}
