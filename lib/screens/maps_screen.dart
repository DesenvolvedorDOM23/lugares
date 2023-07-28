import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplace/models/place_model.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation? initiallocation;
  final bool isReadOnly;
  const MapsScreen({
    this.initiallocation = const PlaceLocation(
      latitude: 37.422131,
      longitude: -122.084801,
    ),
    this.isReadOnly = false,
  });

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedposition;

  void _selectedPosition(LatLng position) {
    setState(() {
      _pickedposition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedposition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedposition);
                    },
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initiallocation!.latitude,
            widget.initiallocation!.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectedPosition,
        markers: (_pickedposition == null && !widget.isReadOnly)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position:
                      _pickedposition ?? widget.initiallocation!.toLatlng(),
                ),
              },
      ),
    );
  }
}
