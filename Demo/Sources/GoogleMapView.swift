
import GoogleMaps
import SwiftUI

struct GoogleMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // update coordinator here
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject {
        // do custom stuff here that is not part of the `GMSMapViewDelegate`
    }
}

extension GoogleMapView.Coordinator: GMSMapViewDelegate {
    // use the `GMSMapViewDelegate` here
}
