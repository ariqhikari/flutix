part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(GoToSplashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(GoToMainPage());
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
                              ? MovieDetailPage(pageState.movie,
                                  isNowPlaying: pageState.isNowPlaying)
                              : (pageState is OnSchedulePage)
                                  ? SchedulePage(pageState.movieDetail)
                                  : (pageState is OnSeatPage)
                                      ? SeatPage(pageState.ticket)
                                      : (pageState is OnCheckoutPage)
                                          ? CheckoutPage(pageState.ticket)
                                          : (pageState is OnSuccessPage)
                                              ? SuccessPage(pageState.ticket,
                                                  pageState.transaction)
                                              : (pageState
                                                      is OnTicketDetailPage)
                                                  ? TicketDetailPage(
                                                      pageState.ticket)
                                                  : (pageState is OnProfilePage)
                                                      ? ProfilePage()
                                                      : (pageState
                                                              is OnTopUpPage)
                                                          ? TopUpPage(pageState
                                                              .pageEvent)
                                                          : (pageState
                                                                  is OnWalletPage)
                                                              ? WalletPage(
                                                                  pageState
                                                                      .pageEvent)
                                                              : (pageState
                                                                      is OnEditProfilePage)
                                                                  ? EditProfilePage(
                                                                      pageState
                                                                          .user)
                                                                  : (pageState
                                                                          is OnMainPage)
                                                                      ? MainPage(
                                                                          bottomNavBarIndex:
                                                                              pageState.bottomNavBarIndex,
                                                                          isExpired:
                                                                              pageState.isExpired,
                                                                        )
                                                                      : Container(),
    );
  }
}
