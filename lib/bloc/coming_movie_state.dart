part of 'coming_movie_bloc.dart';

abstract class ComingMovieState extends Equatable {
  const ComingMovieState();

  @override
  List<Object> get props => [];
}

class ComingMovieInitial extends ComingMovieState {
  @override
  List<Object> get props => [];
}

class ComingMovieLoaded extends ComingMovieState {
  final List<Movie> movies;

  ComingMovieLoaded({this.movies});

  @override
  List<Object> get props => [movies];
}
