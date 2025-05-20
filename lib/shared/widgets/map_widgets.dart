import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapView extends StatefulWidget {
  final String location;
  final double height;

  const LocationMapView({super.key, required this.location, this.height = 200});

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  late GoogleMapController mapController;
  Map<String, LatLng> locationCoordinates = {
    // Preset locations for demo purposes
    'hochiminh': const LatLng(10.762622, 106.660172),
    'hanoi': const LatLng(21.027763, 105.834160),
    'danang': const LatLng(16.047079, 108.206230),
    'cantho': const LatLng(10.045162, 105.746857),
    'hue': const LatLng(16.463713, 107.590866),
    'nhatrang': const LatLng(12.248775, 109.196747),
    'vungtau': const LatLng(10.346937, 107.085717),
    'halong': const LatLng(20.959902, 107.042542),
    'quynhon': const LatLng(13.770718, 109.223392),
    'phanthiet': const LatLng(10.921435, 108.102253),
    // Default for other locations
    'Default': const LatLng(16.047079, 108.206230), // Da Nang as default
  };

  LatLng getCoordinatesForLocation(String location) {
    // If location is empty, return default
    if (location.isEmpty) {
      return locationCoordinates['Default']!;
    }

    // Search through our presets for a match, case insensitive partial match
    for (var entry in locationCoordinates.entries) {
      if (location.toLowerCase().contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }

    // Try matching keywords from the location string
    final locationWords =
        location
            .toLowerCase()
            .split(RegExp(r'[,\s]+'))
            .where((word) => word.isNotEmpty)
            .toList();

    for (final word in locationWords) {
      for (var entry in locationCoordinates.entries) {
        if (entry.key.toLowerCase().contains(word) ||
            word.contains(entry.key.toLowerCase())) {
          return entry.value;
        }
      }
    }

    // If no match found, return default
    return locationCoordinates['Default']!;
  }

  @override
  Widget build(BuildContext context) {
    // Get coordinates based on location string
    final LatLng coordinates = getCoordinatesForLocation(widget.location);

    return SizedBox(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: coordinates,
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('location'),
                  position: coordinates,
                  infoWindow: InfoWindow(title: widget.location),
                ),
              },
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: FloatingActionButton.small(
                heroTag: null,
                backgroundColor: Colors.white,
                onPressed: () {
                  mapController.animateCamera(
                    CameraUpdate.newLatLngZoom(coordinates, 14),
                  );
                },
                child: const Icon(
                  Icons.center_focus_strong,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
