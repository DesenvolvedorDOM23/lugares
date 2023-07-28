import 'package:flutter/material.dart';
import 'package:greatplace/providers/great_place.dart';
import 'package:greatplace/share/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListscreen extends StatefulWidget {
  const PlacesListscreen({super.key});

  @override
  State<PlacesListscreen> createState() => _PlacesListscreenState();
}

class _PlacesListscreenState extends State<PlacesListscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus lugares"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.Place_Form);
              },
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlace>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlace>(
                    child: const Center(
                      child: Text('nenhum local cadastrado '),
                    ),
                    builder: (context, great, child) => great.itemscount == 0
                        ? child!
                        : ListView.builder(
                            itemCount: great.itemscount,
                            itemBuilder: (ctx, i) => ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.Place_Detail,
                                  arguments: great.itemByindex(i),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  great.itemByindex(i).image,
                                ),
                              ),
                              title: Text(
                                great.itemByindex(i).title.toString(),
                              ),
                              subtitle: Text(
                                great.itemByindex(i).location!.adress,
                              ),
                            ),
                          ),
                  ),
      ),
    );
  }
}
