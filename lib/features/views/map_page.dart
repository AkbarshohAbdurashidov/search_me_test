import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../data/models/app_lat_long.dart';
import '../data/service/app_location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

const Color bottonNavBgColor = Color(0x52EBEDF4);
const Color chipLabelsColor = Color(0x332461D3);

class _MapPageState extends State<MapPage> {
  final List<String> chipLabels = [
    'Inglis tili',
    'IELTS',
    'Python',
    'Grafik dizayn',
    'UI/UX',
    'Frontend',
  ];

  final mapControllerCompleter = Completer<YandexMapController>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'My Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Help',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          left: 24, right: 24, top: 30, bottom: 20),
                      decoration: BoxDecoration(
                        color: bottonNavBgColor.withOpacity(0.8),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: bottonNavBgColor.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'What cource are you looking?',
                          enabled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    // text Popular courses
                    Container(
                        child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Popular courses",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    )),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            chipLabels.length,
                            (index) {
                              return Chip(
                                elevation: 10,
                                label: Text(
                                  chipLabels[index],
                                  style: TextStyle(color: Color(0xFF2045FE)),
                                ),
                                backgroundColor: chipLabelsColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // text My address
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("My Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    // GridView
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 130,
                        child: Scrollbar(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: const [
                              Card(
                                color: Color(0xFFEAEBF0),
                                child: ListTile(
                                  title: Text(
                                    "Rayhon Oilaviy kafe \n(Chilonzor Qatortol) 12",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  trailing: Icon(
                                    Icons.location_on_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Card(
                                color: Color(0xFFEAEBF0),
                                child: ListTile(
                                  title: Text(
                                      "Rayhon Oilaviy kafe \n(Chilonzor Qatortol) 12",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  trailing: Icon(
                                    Icons.location_on_rounded,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]);
            },
          );
          _fetchCurrentLocation();
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.gps_fixed),
      ),
      body: Stack(children: [
        YandexMap(
          onMapCreated: (controller) {
            mapControllerCompleter.complete(controller);
          },
        ),
        const Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: ListTile(
            leading: Icon(
              Icons.circle_outlined,
              color: Colors.red,
              size: 20,
            ),
            title: Text("Your address >"),
            titleTextStyle: TextStyle(fontSize: 14, color: Colors.black),
            subtitle: Text("Chilonzor"),
            subtitleTextStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Icon(
            Icons.location_on_outlined,
            color: Colors.red,
            size: 40,
          ),
        ),
      ]),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = UzbekistanLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
