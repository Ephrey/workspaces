import 'package:flutter/material.dart';

class Destinations {
  String id;
  String name;
  String location;
  List<String> explorers;
  String when;
  bool isFavorite;
  String image;
  String description;

  Destinations({
    @required this.id,
    @required this.name,
    @required this.location,
    this.explorers,
    @required this.when,
    this.isFavorite,
    @required this.image,
    this.description,
  });
}

List<Destinations> destinations = [
  Destinations(
    id: 'destination_1',
    name: 'Lion\'s Head',
    location: 'Cape Town - South Africa',
    explorers: [
      'explorer_1',
      'explorer_2',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
    when: 'Tomorrow',
    isFavorite: false,
    image: 'cape_town.jpg',
    description: "Lion's Head (!Orakobab: Xammi Mũ!’ab) is a"
        "mountain in Cape Town, South Africa, between "
        "Table Mountain and Signal Hill. Lion's Head peaks"
        "at 669 metres (2,195 ft) above sea level. \n \n"
        "The peak forms part of a dramatic backdrop to the city of Cape Town \n \n"
        "and is part of the Table Mountain National Park. \n \n"
        "The suburbs of the city surround the peak and Signal Hill on almost "
        "all sides, but strict management by city authorities has kept "
        "development of housing off the higher ground. \n \n"
        "The area is significant to the Cape Malay community, who historically "
        "lived in the Bo-Kaap quarter close to Lion's Head. \n \n"
        "There are a number of historic graves and shrines (kramats) of Malay "
        "leaders on the lower slopes and on Signal Hill.",
  ),
  Destinations(
    id: 'destination_2',
    name: 'South Beach',
    location: 'Durban - South Africa',
    explorers: [
      'explorer_3',
      'explorer_4',
      '',
      '',
      '',
      '',
    ],
    when: 'In 2 days',
    isFavorite: true,
    image: 'durban.jpg',
    description: "Busy South Beach, part of the Golden Mile,"
        "is home to Durban Fun world amusement park, featuring cable"
        "car rides and swimming pools with slides. The New Pier has \n \n"
        "city and coastline views, and rickshaw drivers in beaded "
        "headdresses offer rides. The area is popular for surfing, \n \n"
        "swimming, and cycling, while casual eateries serve burgers, "
        "fish and chips, and pizza. Bars and lounges stay open late "
        "into the evening.",
  ),
  Destinations(
    id: 'destination_3',
    name: 'Bloemfontein',
    location: 'Johannesburg - South Africa',
    explorers: [
      'explorer_5',
      'explorer_6',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
    when: 'In 5 days',
    isFavorite: false,
    image: 'johannesburg.jpg',
    description:
        "Bloemfontein (/ˈbluːmfɒnteɪn/;[3][4] Afrikaans: [ˈblumfɔntɛin]; "
        "also known as Bloem) is the capital city of the province of Free State "
        "of South Africa; and, as the judicial capital of the nation, one of "
        "South Africa's three national capitals (the other two being Cape Town, "
        "the legislative capital, and Pretoria, the administrative capital) "
        "and is the seventh largest city in South Africa. \n"
        "Situated at an elevation of 1,395 m (4,577 ft) above sea level,"
        "the city is home to approximately 520,000[5] residents and forms part "
        "of the Mangaung Metropolitan Municipality "
        "which has a population of 747,431. \n"
        "It was one of the host cities for the 2010 FIFA World Cup. \n"
        "The city of Bloemfontein hosts the Supreme Court of Appeal of "
        "South Africa, the Franklin Game Reserve, Naval Hill, "
        "the Maselspoort Resort and the Sand du Plessis Theatre. \n"
        "The city hosts numerous museums, including the National "
        "Women's Monument, the Anglo-Boer War Museum, the National Museum, "
        "and the Oliewenhuis Art Museum.",
  )
];

// ############

List<Destinations> upcomingDestinations = [
  Destinations(
    id: 'destination_1',
    name: 'Matterhorn',
    location: 'Aosta Valley - Italy',
    explorers: [
      'explorer_6',
      'explorer_5',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
    when: 'In 1 Week',
    isFavorite: true,
    image: 'up_coming_dest_1.jpg',
    description: "Valle d’Aosta is a region of northwest Italy bordered by "
        "France and Switzerland. Lying in the Western Alps, it's known \n \n"
        "for the iconic, snow-capped peaks the Matterhorn, Mont Blanc,"
        "Monte Rosa and Gran Paradiso. \n \n"
        "Major ski resorts include Courmayeur and Cervinia. \n \n"
        "The region’s countryside is dotted "
        "with medieval castles and fortresses, such as the 14th-century"
        "Castello Fénis and Castello di Verrès.",
  ),
  Destinations(
    id: 'destination_2',
    name: 'Lac Blanc',
    location: 'Chamonix - France',
    explorers: [
      'explorer_4',
      'explorer_3',
      '',
      '',
      '',
      '',
    ],
    when: 'In 2 weeks',
    isFavorite: true,
    image: 'up_coming_dest_2.jpg',
    description: "Located in the Aiguilles Rouges nature reserve, one of the "
        "most beautiful mountain lakes, famous for its unique panorama facing"
        "the Mont-Blanc massif.",
  ),
  Destinations(
    id: 'destination_3',
    name: 'Ciucaș Peak',
    location: 'Romania',
    explorers: [
      'explorer_2',
      'explorer_1',
      '',
      '',
      '',
    ],
    when: 'In 3 weeks',
    isFavorite: true,
    image: 'up_coming_dest_3.jpg',
    description: "The Ciucaș Mountains is a mountain range in Romania."
        "The highest peak is Vârful Ciucaș, at 1,954 meters. The headwaters"
        "of the Buzău River, the Teleajen River, the Tărlung River and many "
        "others are located there. \n \n"
        "In Romania, the Ciucaș Mountains are considered part of the "
        "Curvature Carpathians.",
  )
];

// ############

List<Destinations> popularDestinations = [
  Destinations(
    id: 'destination_1',
    name: 'Puerta de Alcalá',
    location: 'Madrid - Spain',
    explorers: [
      'explorer_4',
      'explorer_1',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
    when: 'Now',
    isFavorite: false,
    image: 'madrid.jpg',
    description:
        "The Puerta de Alcalá is a Neo-classical monument in the Plaza "
        "de la Independencia in Madrid, Spain. It is regarded as the first "
        "modern post-Roman triumphal arch built in Europe, older than the"
        "similar monuments Arc de Triomphe in Paris and Brandenburg Gate "
        "in Berlin. \n \n"
        "It was a gate of the former Walls of Philip IV.",
  ),
  Destinations(
    id: 'destination_2',
    name: 'The Eiffel Tower',
    location: 'Paris - France',
    explorers: [
      'explorer_2',
      'explorer_6',
      '',
      '',
      '',
      '',
    ],
    when: 'In 20 minutes',
    isFavorite: false,
    image: 'paris.jpg',
    description: "The Eiffel Tower is a wrought-iron lattice tower on the"
        "Champ de Mars in Paris, France.\n \n "
        "It is named after the engineer Gustave Eiffel, whose company "
        "designed and built the tower.",
  ),
  Destinations(
    id: 'destination_3',
    name: 'Opera House',
    location: 'Sydney - Australia',
    explorers: [
      'explorer_3',
      'explorer_5',
      '',
      '',
      '',
    ],
    when: 'In 2 hours',
    isFavorite: true,
    image: 'sydney.jpg',
    description: "The Sydney Opera House is a multi-venue performing arts "
        "centre at Sydney Harbour in Sydney, New South Wales, Australia. \n \n"
        "It is one of the 20th century's most famous and distinctive buildings.",
  )
];
