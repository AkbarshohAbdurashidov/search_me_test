import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:search_me_test/features/data/repository/address_dateail_repository.dart';
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
const Color backgroundColor = Color.fromARGB(51, 252, 252, 252);

class _MapPageState extends State<MapPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  String addressDetail = "Loading your location";
  final AddressDetailRepository repository = AddressDetailRepository();

  int _selectedIndex = 0;
  final List<String> chipLabels = [
    'Inglis tili',
    'IELTS',
    'Python',
    'Grafik dizayn',
    'UI/UX',
    'Frontend',
  ];

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
        decoration: const BoxDecoration(
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
          _fetchCurrentLocation();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.gps_fixed),
      ),
      body: Stack(children: [
        YandexMap(
          onMapCreated: (controller) {
            mapControllerCompleter.complete(controller);
          },
          onCameraPositionChanged: (cameraPosition, reason, finished) {
            if (finished) {
              updateAddressDetail(AppLatLong(
                  lat: cameraPosition.target.latitude,
                  long: cameraPosition.target.longitude));
            }
          },
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              showDragHandle: true,
              // enableDrag: true,
              useRootNavigator: false,
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
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: SearchBar(
                          controller: SearchController(),
                          hintText: 'What course are you looking?',
                          leading: const Icon(Icons.search_outlined),
                        ),
                      ),

                      // text Popular courses
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Popular courses",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            chipLabels.length,
                            (index) {
                              return Chip(
                                elevation: 10,
                                shadowColor: const Color(0xFF2045FE),
                                label: Text(
                                  chipLabels[index],
                                  style:
                                      const TextStyle(color: Color(0xFF2045FE)),
                                ),
                                backgroundColor: chipLabelsColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              );
                            },
                          ),
                        ),
                      ),
                      // text My address
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("My Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      // GridView
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
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
          },
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: ListTile(
              leading: const Icon(
                Icons.circle_outlined,
                color: Colors.red,
                size: 20,
              ),
              title: const Text("Your address >"),
              titleTextStyle:
                  const TextStyle(fontSize: 14, color: Colors.black),
              subtitle: Text(addressDetail),
              subtitleTextStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
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
    updateAddressDetail(location);
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
          zoom: 14,
        ),
      ),
    );
  }

  Future<void> updateAddressDetail(AppLatLong latLong) async {
    
    try {
      addressDetail = "Just one sec...";
      setState(() {});
      Point point = Point(latitude: latLong.lat, longitude: latLong.long);
      final results = YandexSearch.searchByPoint(
        point: point,
        searchOptions: const SearchOptions(),
        
      );
      
      final session = await results.result;
      addressDetail =  session.items?.first.name ?? '';
      setState(() {});
    } catch (e) {
      addressDetail = e.toString();
      setState(() {});
      log("Error: $e");
    }
  }
}