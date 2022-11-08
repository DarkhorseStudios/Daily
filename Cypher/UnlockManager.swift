import Combine
import StoreKit
/*
/* HWS Tutorial:
https://www.hackingwithswift.com/plus/ultimate-portfolio-app/offering-in-app-purchases-part-1
*/
//Is used for IAPs

/*I have a successful test purchase configuration, but I still need to enable it:
That finishes configuring our example purchase, so now we can tell Xcode to inject that into our app when running in debug mode. To do that, go to the Product menu, hold down Option, then select “Run…” to bring up the scheme editor. Now select the Options tab and change StoreKit Configuration from None to Configuration.storekit.

So, now we have a basic UnlockManager class in place as well as a product we can purchase, so now we’re back to
*/

class UnlockManager: NSObject, ObservableObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {

enum requestState {
case loading //Means we've started the request but dont have a response yet
case loaded(SKProduct) //Means we have successful response from Apple describing available purchases
case failed(Error?) //Means either the request failed or something went wrong with the purchase
case purchased //Means user has successfully purchased IAP or restored previous purchase
case deferred ///Means the user can't make the purchase themselves, like when a minor needs permission
}//RequestState

//This enum is only used for cases when the requestState fails.
private enum StoreError: Error {
case invalidIdentifiers, missingProduct
}//StoreError

@Published var requestState = requestState.loading

//Methods for conformance to StoreKit protocols

/* stashes away the list of products that were sent back, then pulls out the first product that was returned, or flags up an error if none could be found. It will then check there were no invalid identifiers, but if there were we’ll flag up a different error. Finally, if we have a product and no invalid identifiers, we’ll consider our store to be loaded.
Important: All this must be done on the main thread. We’re going to be adjusting the requestState property, and because that’s marked with @Published it may trigger SwiftUI views to be updated.
This method Gets called when our product request completes successfully, even if that means no products were returned
*/
func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    DispatchQueue.main.async {
        // Store the returned products for later, if we need them.
        self.loadedProducts = response.products

        guard let unlock = self.loadedProducts.first else {
            self.requestState = .failed(StoreError.missingProduct)
            return
        }

        if response.invalidProductIdentifiers.isEmpty == false {
            print("ALERT: Received invalid product identifiers: \(response.invalidProductIdentifiers)")
            self.requestState = .failed(StoreError.invalidIdentifiers)
            return
        }

        self.requestState = .loaded(unlock)
    }
}//Pfunc productRequest
}//class

*/
