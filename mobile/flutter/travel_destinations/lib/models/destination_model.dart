import 'package:flutter/material.dart';

class Destinations {
  String id;
  String name;
  String location;
  List<String> explorer;
  String when;
  bool isFavorite;
  String image;
  String description;

  Destinations({
    @required this.id,
    @required this.name,
    @required this.location,
    this.explorer,
    @required this.when,
    this.isFavorite,
    this.description,
  });
}

List<Destinations> destinations = [
  Destinations(
    id: 'destination_1',
    name: 'Lion Head',
    location: 'Capetown - South Africa',
    explorer: [
      'explorer_1',
      'explorer_2',
    ],
    when: 'Tomorrow',
    isFavorite: false,
    description: "Lion's Head (!Orakobab: Xammi Mũ!’ab) is a"
        "mountain in Cape Town, South Africa, between "
        "Table Mountain and Signal Hill. Lion's Head peaks"
        "at 669 metres (2,195 ft) above sea level. The peak"
        "forms part of a dramatic backdrop to the city of Cape Town"
        "and is part of the Table Mountain National Park.",
  ),
  Destinations(
    id: 'destination_2',
    name: 'South Beach',
    location: 'Durban - South Africa',
    explorer: [
      'explorer_3',
      'explorer_4',
    ],
    when: 'In 2 days',
    isFavorite: false,
    description: "Busy South Beach, part of the Golden Mile,"
        "is home to Durban Funworld amusement park, featuring cable"
        "car rides and swimming pools with slides. The New Pier has"
        "city and coastline views, and rickshaw drivers in beaded "
        "headdresses offer rides. The area is popular for surfing, "
        "swimming, and cycling, while casual eateries serve burgers, "
        "fish and chips, and pizza. Bars and lounges stay open late "
        "into the evening.",
  ),
  Destinations(
    id: 'destination_3',
    name: 'Bloemfontein',
    location: 'Johannesburg - South Africa',
    explorer: [
      'explorer_5',
      'explorer_6',
    ],
    when: 'In 5 days',
    isFavorite: false,
    description: "Busy South Beach, part of the Golden Mile,"
        "is home to Durban Funworld amusement park, featuring cable"
        "car rides and swimming pools with slides. The New Pier has"
        "city and coastline views, and rickshaw drivers in beaded "
        "headdresses offer rides. The area is popular for surfing, "
        "swimming, and cycling, while casual eateries serve burgers, "
        "fish and chips, and pizza. Bars and lounges stay open late "
        "into the evening.",
  )
];
