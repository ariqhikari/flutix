import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'coming_movie_event.dart';
part 'coming_movie_state.dart';

class ComingMovieBloc extends Bloc<ComingMovieEvent, ComingMovieState> {
  ComingMovieBloc() : super(ComingMovieInitial());

  @override
  Stream<ComingMovieState> mapEventToState(
    ComingMovieEvent event,
  ) async* {
    if (event is FetchComingSoonMovies) {
      List<Movie> movies = await MovieServices.getComingSoonMovies(1);

      yield (ComingMovieLoaded(movies: movies));
    }
  }
}
