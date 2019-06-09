import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  final FocusNode _addressInputFocusNode = new FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressInputFocusNode.addListener(_updateLocation);
  }

  @override
  void dispose() {
    super.dispose();
    _addressInputFocusNode.removeListener(_updateLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _addressInputController,
          decoration: InputDecoration(labelText: 'Address'),
        ),
        SizedBox(height: 10),
        _staticMapUri.toString() == null ? SizedBox(height: 10) : Image.network(_staticMapUri.toString())
      ],
    );
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      getStaticMap(_addressInputController.text.toString());
    }
  }

  void getStaticMap(String address) async {
    if (address.isEmpty) return;

    final Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {'address': address, 'key': 'AIzaSyDf2U-_haGFU6N8A44uZw84YKQe224a4NQ'},
    );
    final http.Response response = await http.get(uri);
    final decodedResponse = jsonDecode(response.body);
    print('=========$decodedResponse');
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    final coords = decodedResponse['results'][0]['geometry']['location'];
    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyDf2U-_haGFU6N8A44uZw84YKQe224a4NQ');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
      [Marker('position', 'Position', coords['lat'], coords['lng'])],
      center: Location(coords['lat'], coords['lng']),
      maptype: StaticMapViewType.roadmap,
      width: 500,
      height: 300,
    );
    setState(() {
      _staticMapUri = staticMapUri;
      _addressInputController.text = formattedAddress;
    });
  }
}
