import 'models/movies.dart';

List<Movies> movie = List.generate(
    6,
    (index) => Movies(
        title: "Mulan $index",
        rating: 2.6,
        length: '113min',
        ytUrl: 'https://www.youtube.com/watch?v=KK8FHdFluOQ',
        year: 2019,
        country: 'USA',
        details: 'A young Chinese maiden disguises herself as a male warrior in order to save her father.',
        genres: ["Action", "Adventure", "Martial Arts"],),
        
        );
