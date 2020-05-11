class UsersModel {
  String name;
  String jobTitle;
  double rating;
  int jobCount;
  String rate;
  String profilePicture;
  bool isFavorite;

  UsersModel({
    this.name,
    this.jobTitle,
    this.rating,
    this.jobCount,
    this.rate,
    this.profilePicture,
    this.isFavorite: false,
  });
}

List<UsersModel> usersModel = [
  UsersModel(
    name: 'Bob Doherty',
    jobTitle: 'Electrician',
    rating: 4.2,
    jobCount: 393,
    rate: 'R100/h',
    profilePicture: 'user_5',
  ),
  UsersModel(
    name: 'Mary Lane',
    jobTitle: 'Baddy Sister',
    rating: 4.9,
    jobCount: 33,
    rate: 'R150/h',
    profilePicture: 'user_1',
  ),
  UsersModel(
    name: 'Laura Kanane',
    jobTitle: 'Floor Cleaning',
    rating: 5.0,
    jobCount: 42,
    rate: 'R80/h',
    profilePicture: 'user_4',
  ),
  UsersModel(
    name: 'Louis Mako',
    jobTitle: 'Plumber',
    rating: 3.8,
    jobCount: 38,
    rate: 'R305/h',
    profilePicture: 'user_3',
  ),
];

List<UsersModel> babySitters = [
  UsersModel(
    name: 'Jenny Powell',
    jobTitle: 'Baddy Sister',
    rating: 4.8,
    jobCount: 33,
    rate: 'R250/h',
    profilePicture: 'user_1_b',
    isFavorite: false,
  ),
  UsersModel(
    name: 'Kim Hawkins',
    jobTitle: 'Baddy Sister',
    rating: 4.9,
    jobCount: 33,
    rate: 'R370/h',
    profilePicture: 'user_2_b',
    isFavorite: true,
  ),
];

List<UsersModel> recommendedBabySitters = [
  UsersModel(
    name: 'Tiffany Nash',
    jobTitle: 'Baddy Sister',
    rating: 4.5,
    jobCount: 33,
    rate: 'R280/h',
    profilePicture: 'user_1_r',
    isFavorite: true,
  ),
  UsersModel(
    name: 'Laurie Henderson',
    jobTitle: 'Baddy Sister',
    rating: 4.9,
    jobCount: 33,
    rate: 'R420/h',
    profilePicture: 'user_2_r',
    isFavorite: true,
  ),
];
