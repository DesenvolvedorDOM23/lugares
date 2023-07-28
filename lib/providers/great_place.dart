import 'dart:io';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplace/models/place_model.dart';
import 'package:greatplace/share/utils/db/db_utils.dart';
import 'package:greatplace/share/utils/location/location_util.dart';


class GreatPlace with ChangeNotifier {
  List<PlaceModel> _items = [];

  Future<void> loadPlaces() async {
    final datalist = await DbUtils.getData('places');
    _items = datalist
        .map(
          (item) => PlaceModel(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              adress: item['adress'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  List<PlaceModel> get items {
    return [..._items];
  }

  int get itemscount {
    return _items.length;
  }

  itemByindex(int index) {
    return _items[index];
  }

  void addiPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAdressFrom(position);

    final newPlace = PlaceModel(
        id: Random().nextDouble().toString(),
        title: title,
        image: image,
        location: PlaceLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          adress: address,
        ));
    _items.add(newPlace);

    DbUtils.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
