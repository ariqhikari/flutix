part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // * Header
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((downloadURL) {
                    imageFileToUpload = null;
                    context
                        .bloc<UserBloc>()
                        .add(UpdateData(profilePicture: downloadURL));
                  });
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToProfilePage());
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF5F558B),
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            SpinKitFadingCircle(color: accentColor2, size: 50),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (userState.user.profilePicture == ''
                                      ? AssetImage('assets/user_pic.png')
                                      : NetworkImage(
                                          userState.user.profilePicture)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (2 * defaultMargin) -
                              78,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToWalletPage(GoToMainPage()));
                          },
                          child: Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                              symbol: 'IDR ',
                            ).format(userState.user.balance),
                            style: yellowNumberFont.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(color: accentColor2, size: 50);
              }
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Now Playing
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 12),
                child: Text(
                  'Now Playing',
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              ),
              Container(
                height: 140,
                child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (_, movieState) {
                  if (movieState is MovieLoaded) {
                    List<Movie> movies = movieState.movies.sublist(0, 10);

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.only(right: 16),
                        child: MovieCard(
                          movies[index],
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMovieDetailPage(movies[index]));
                          },
                        ),
                      ),
                    );
                  } else {
                    return SpinKitFadingCircle(
                      color: mainColor,
                      size: 50,
                    );
                  }
                }),
              ),
              // * Browse Movie
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 12),
                child: Text(
                  'Browse Movie',
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              ),
              BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                if (userState is UserLoaded) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        userState.user.selectedGenres.length,
                        (index) =>
                            BrowseButton(userState.user.selectedGenres[index]),
                      ),
                    ),
                  );
                } else {
                  return SpinKitFadingCircle(color: mainColor, size: 50);
                }
              }),
              // * Coming Soon
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 12),
                child: Text(
                  'Coming Soon',
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              ),
              Container(
                height: 140,
                child: BlocBuilder<ComingMovieBloc, ComingMovieState>(
                    builder: (_, movieState) {
                  if (movieState is ComingMovieLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieState.movies.length,
                      itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.only(right: 16),
                        child: ComingSoonCard(movieState.movies[index]),
                      ),
                    );
                  } else {
                    return SpinKitFadingCircle(
                      color: mainColor,
                      size: 50,
                    );
                  }
                }),
              ),
              // * Get lucky Day
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 12),
                child: Text(
                  'Get Lucky Day',
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 138),
                child: Column(
                  children:
                      dummyPromos.map((promo) => PromoCard(promo)).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
