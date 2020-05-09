class UsersModel {
  String name;
  String jobTitle;
  double rating;
  int jobCount;
  String rate;
  String profilePicture;

  UsersModel({
    this.name,
    this.jobTitle,
    this.rating,
    this.jobCount,
    this.rate,
    this.profilePicture,
  });
}

List<UsersModel> usersModel = [
  UsersModel(
    name: 'Bob Doherty',
    jobTitle: 'Electrician',
    rating: 4.2,
    jobCount: 393,
    rate: '100/h',
    profilePicture: 'user_5',
  ),
  UsersModel(
    name: 'Laura Kanane',
    jobTitle: 'Floor Cleaning',
    rating: 5.0,
    jobCount: 42,
    rate: '80/h',
    profilePicture: 'user_4',
  ),
  UsersModel(
    name: 'Louis Mako',
    jobTitle: 'Plumber',
    rating: 3.8,
    jobCount: 38,
    rate: '305/h',
    profilePicture: 'user_3',
  ),
  UsersModel(
    name: 'Mary Lane',
    jobTitle: 'Baddy Sister',
    rating: 4.9,
    jobCount: 33,
    rate: '150/h',
    profilePicture: 'user_1',
  ),
];
