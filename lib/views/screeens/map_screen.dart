import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:last_uber/views/screeens/home_screen.dart';
import 'package:last_uber/views/screeens/main_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

      late GoogleMapController mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(42.30081560924404, 69.7604860708247),
    zoom: 14.4746,
  );
  late Position
      currentPosition; // Объявляем переменную currentPosition для хранения текущего местоположения. Мы используем "late", чтобы отложить её инициализацию.

  getUserCurrentLocation() async {
    // Объявляем асинхронную функцию getUserCurrentLocation.
    await Geolocator
        .checkPermission(); // Ждем завершения проверки разрешения на доступ к геолокации.

    await Geolocator
        .requestPermission(); // Ждем завершения запроса разрешения на доступ к геолокации.

    Position position = await Geolocator.getCurrentPosition(
      // Запрашиваем текущее местоположение пользователя и ждем его получения.
      desiredAccuracy: LocationAccuracy
          .bestForNavigation, // Устанавливаем желаемую точность геолокации.
      forceAndroidLocationManager:
          true, // Принудительно используем менеджер геолокации Android.
    );

    currentPosition = position; 

    LatLng pos = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: pos,zoom: 16);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.only(bottom: 200),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              mapController = controller;

              getUserCurrentLocation();
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 241, 194, 209)),
                        ),
                        onPressed: () {
                          Get.offAll(MainScreen());
                        },
                        icon: Icon(
                          CupertinoIcons.shopping_cart,
                          color: Colors.pink,
                        ),
                        label: Text(
                          'Купить сейчас',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
