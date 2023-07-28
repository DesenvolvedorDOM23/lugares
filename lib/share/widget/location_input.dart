import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplace/screens/maps_screen.dart';
import 'package:greatplace/share/utils/location/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPosition;
  const LocationInput(this.onSelectedPosition, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double long) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: long,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locdata = await Location().getLocation();
    try {
      _showPreview(locdata.latitude!, locdata.longitude!);
      widget.onSelectedPosition(LatLng(
        locdata.latitude!,
        locdata.longitude!,
      ));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectedOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MapsScreen()),
    );
    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.onSelectedPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text('nenhuma localização ')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
            ),
            const SizedBox(
              width: 15,
            ),
            TextButton.icon(
              onPressed: _selectedOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Escolher no mapa '),
            ),
          ],
        )
      ],
    );
  }
}
