import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocationUser() async {
    final locationData = await Location().getLocation();
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
              ? const Text('Localização não informada!')
              : Image.network(
                  _previewImageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocationUser,
              label: const Text('Localização Atual'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () => {},
              label: const Text('Selecione no Mapa'),
              icon: const Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }
}
