import 'package:flutter/material.dart';
import 'package:greatplace/providers/great_place.dart';
import 'package:greatplace/screens/placesdetail_screen.dart';
import 'package:provider/provider.dart';
import 'package:greatplace/screens/form_screen.dart';
import 'package:greatplace/screens/places_list_screen.dart';
import 'package:greatplace/share/utils/routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlace(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        routes: {
          AppRoutes.home: (context) => const PlacesListscreen(),
          AppRoutes.Place_Form: (context) => const FormScreen(),
          AppRoutes.Place_Detail: (contex) => const PlacesdetailScreen()
        },
      ),
    );
  }
}
