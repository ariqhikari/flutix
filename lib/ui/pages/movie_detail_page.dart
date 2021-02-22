part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor1),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: [
                FutureBuilder(
                  future: MovieServices.getDetailsMovie(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data;
                    }

                    return Column(
                      children: [
                        // * Header
                        Stack(
                          children: [
                            Container(
                              height: 270,
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageBaseURL +
                                      'w500' +
                                      movie.backdropPath),
                                ),
                              ),
                              child: Container(
                                height: 271,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0, 1),
                                    end: Alignment(0, 0.06),
                                    colors: [
                                      Colors.white,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 36, left: defaultMargin),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onTap: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToMainPage(bottomNavBarIndex: 0));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(fontSize: 24),
                        ),
                        SizedBox(height: 6),
                        (snapshot.hasData)
                            ? Text(
                                movieDetail.genresAndLanguage,
                                textAlign: TextAlign.center,
                                style: greyTextFont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )
                            : SizedBox(
                                height: 50,
                                width: 50,
                                child: SpinKitFadingCircle(
                                  color: accentColor3,
                                ),
                              ),
                        SizedBox(height: 6),
                        RatingStars(
                          voteAverage: movie.voteAverage,
                          color: accentColor3,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                        ),
                        // * Cast & Crew, Storyline
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // * Cast & Crew
                              Container(
                                margin: EdgeInsets.only(top: 24, bottom: 12),
                                child: Text(
                                  'Cast & Crew',
                                  style: blackTextFont.copyWith(fontSize: 16),
                                ),
                              ),
                              FutureBuilder(
                                future: MovieServices.getCreditsMovie(movie.id),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    credits = snapshot.data;
                                    return SizedBox(
                                      height: 115,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: credits.length,
                                        itemBuilder: (_, index) => Container(
                                          margin: EdgeInsets.only(right: 16),
                                          child: CreditCard(credits[index]),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                        height: 50,
                                        child: SpinKitFadingCircle(
                                          color: accentColor1,
                                        ));
                                  }
                                },
                              ),
                              // * Storyline
                              Container(
                                margin: EdgeInsets.only(top: 24, bottom: 8),
                                child: Text(
                                  'Storyline',
                                  style: blackTextFont.copyWith(fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: Text(
                                  movie.overview,
                                  style: greyTextFont.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // * Next Button
                        Container(
                          width: 250,
                          height: 45,
                          margin: EdgeInsets.only(bottom: 40),
                          child: RaisedButton(
                            elevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            hoverElevation: 0,
                            child: Text(
                              'Continue To Book',
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: mainColor,
                            onPressed: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToSchedulePage(movieDetail));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
