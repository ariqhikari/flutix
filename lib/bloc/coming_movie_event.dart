part of 'coming_movie_bloc.dart';

abstract class ComingMovieEvent extends Equatable {
  const ComingMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchComingSoonMovies extends ComingMovieEvent {
  @override
  List<Object> get props => [];
}
