import 'package:flutter/material.dart';
import 'package:greatplace/models/place_model.dart';
import 'package:greatplace/screens/maps_screen.dart';

class PlacesdetailScreen extends StatefulWidget {
  const PlacesdetailScreen({super.key});

  @override
  State<PlacesdetailScreen> createState() => _PlacesdetailScreenState();
}

class _PlacesdetailScreenState extends State<PlacesdetailScreen> {
  @override
  Widget build(BuildContext context) {
    PlaceModel args = ModalRoute.of(context)!.settings.arguments as PlaceModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              args.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(args.location.adress!),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapsScreen(
                        isReadOnly: true,
                        initiallocation: args.location,
                      )));
            },
            icon: const Icon(Icons.map),
            label: const Text('ver no mapa'),
          )
        ],
      ),
    );
  }
}
