import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'coming_movie_event.dart';
part 'coming_movie_state.dart';

class ComingMovieBloc extends Bloc<ComingMovieEvent, ComingMovieState> {
  @override
  ComingMovieState get initialState => ComingMovieInitial();

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
