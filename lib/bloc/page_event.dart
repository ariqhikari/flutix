part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  GoToPreferencePage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final int bottomNavbarIndex;

  GoToMainPage(this.bottomNavbarIndex);

  @override
  List<Object> get props => [bottomNavbarIndex];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;

  GoToMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}

class GoToSchedulePage extends PageEvent {
  final MovieDetail movieDetail;

  GoToSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GoToSeatPage extends PageEvent {
  final Ticket ticket;

  GoToSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;

  GoToCheckoutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final FlutixTransaction transaction;

  GoToSuccessPage(this.ticket, this.transaction);

  @override
  List<Object> get props => [ticket, transaction];
}
