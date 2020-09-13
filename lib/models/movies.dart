class Movies {
  int id;
  String title;
  List<String> genres;
  String details;
  String country;
  String length;
  int year;
  double rating;
  String ytUrl;
  
  Movies(
      {this.country,
      this.details,
      this.genres,
      this.id,
      this.length,
      this.rating,
      this.title,
      this.year,
      this.ytUrl});
  factory Movies.fromMap(Map json)=>Movies(
    id: int.parse(json['id']),
    title:json['title'],
    country: json['country'],
    length: json['length'],
    rating: double.parse(json['rating']),
    year: int.parse(json['year']),
    genres: (json['genres'] as List).map((e) => e.toString()).toList(),
    details: json['details'],
    ytUrl: json['ytUrl']
  );
}
