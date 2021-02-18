part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(GoToSplashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));

        prevPageEvent = GoToMainPage(0);
        context.bloc<PageBloc>().add(GoToMainPage(0));
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnSplashPage)
          ? SplashPage()
          : (pageState is OnLoginPage)
              ? SignInPage()
              : (pageState is OnRegistrationPage)
                  ? SignUpPage(pageState.registrationData)
                  : (pageState is OnPreferencePage)
                      ? PreferencePage(pageState.registrationData)
                      : (pageState is OnAccountConfirmationPage)
                          ? AccountConfirmationPage(pageState.registrationData)
                          : (pageState is OnMovieDetailPage)
                              ? MovieDetailPage(pageState.movie)
                              : (pageState is OnSchedulePage)
                                  ? SchedulePage(pageState.movieDetail)
                                  : (pageState is OnSeatPage)
                                      ? SeatPage(pageState.ticket)
                                      : (pageState is OnCheckoutPage)
                                          ? CheckoutPage(pageState.ticket)
                                          : (pageState is OnSuccessPage)
                                              ? SuccessPage(pageState.ticket,
                                                  pageState.transaction)
                                              : MainPage(pageState is OnMainPage
                                                  ? pageState.bottomNavbarIndex
                                                  : 0),
    );
  }
}
