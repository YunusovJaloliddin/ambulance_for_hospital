import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../common/models/booking.dart';

class LocationScreen extends StatefulWidget {
  final Booking booking;

  const LocationScreen({super.key, required this.booking});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<YandexMapController> _completer = Completer();
  ValueNotifier<List<MapObject>> mapObjects = ValueNotifier([]);
  ScrollController scrollController = ScrollController();
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    scrollController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    scrollController.removeListener(() {});
  }

  void onMapCreated(controller) async {
    _completer.complete(controller);
    await controller.toggleUserLayer(visible: true);
    await controller.getUserCameraPosition();
    Position position = await Geolocator.getCurrentPosition();
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: widget.booking.point.latitude,
            longitude: widget.booking.point.longitude,
          ),
        ),
      ),
    );
    mapObjects.value = [
      PlacemarkMapObject(
        mapId: const MapObjectId("user"),
        point: Point(
          latitude: widget.booking.point.latitude,
          longitude: widget.booking.point.longitude,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              "assets/images/marker.png",
            ),
            scale: 1 / 15,
          ),
        ),
      ),
    ];
    List<Point> markers = [
      Point(
        latitude: widget.booking.point.latitude,
        longitude: widget.booking.point.longitude,
      ),
      Point(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    ];
    getDirections(markers);
  }

  getDirections(List<Point> markers) async {
    List<PolylineWayPoint> polylineWayPoints = [];
    for (var i = 0; i < markers.length; i++) {
      polylineWayPoints.add(PolylineWayPoint(
          location: "${markers[i].latitude},${markers[i].longitude}",
          stopOver: true));
    }
    PolylineMapObject polylineMapObject = PolylineMapObject(
      mapId: const MapObjectId("User"),
      polyline: Polyline(points: markers),
    );
    polylinePoints.getRouteBetweenCoordinates(
      "fc8b36d3-c7c1-48be-9150-e53ac6f07438",
      PointLatLng(markers.first.latitude, markers.first.longitude),
      //first added marker
      PointLatLng(markers.last.latitude, markers.last.longitude),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            pinned: true,
            title: Text(widget.booking.address),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: kToolbarHeight * 2),
                itemExtent: size.height * 0.05,
                children: [
                  Text(
                      "Name: ${widget.booking.userModel.name} ${widget.booking.userModel.fulName}"),
                  Text(" Age: ${widget.booking.userModel.age}"),
                  Text("Reason: ${widget.booking.reason}"),
                ],
              ),
            ),
          ),
        ],
        body: Center(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ValueListenableBuilder(
                valueListenable: mapObjects,
                builder: (context, _, child) {
                  return YandexMap(
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    onMapCreated: onMapCreated,
                    mapObjects: mapObjects.value,
                    rotateGesturesEnabled: false,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
