part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    'Horror',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime',
  ];
  final List<String> languages = [
    'Bahasa',
    'English',
    'Japanese',
    'Korean',
  ];

  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.registrationData.password = '';
        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 36, bottom: 20),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back, color: Colors.black),
                      onTap: () {
                        widget.registrationData.password = '';
                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(widget.registrationData));
                      },
                    ),
                  ),
                  Text(
                    'Select Your\nFavorite Genre',
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Movie Language\nYou Prefer?',
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLanguageWidgets(context),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: FloatingActionButton(
                      elevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      backgroundColor: mainColor,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (widget.registrationData.selectedGenres.length !=
                            4) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Please select 4 genres',
                          )..show(context);
                        } else {
                          context.bloc<PageBloc>().add(
                              GoToAccountConfirmationPage(
                                  widget.registrationData));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 24) / 2;

    return widget.genres
        .map((genre) => SelectableBox(
              genre,
              width: width,
              isSelected:
                  widget.registrationData.selectedGenres.contains(genre),
              onTap: () {
                onSelectGenre(genre);
              },
            ))
        .toList();
  }

  List<Widget> generateLanguageWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 24) / 2;

    return widget.languages
        .map((language) => SelectableBox(
              language,
              width: width,
              isSelected: widget.registrationData.selectedLanguage == language,
              onTap: () {
                setState(() {
                  widget.registrationData.selectedLanguage = language;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (widget.registrationData.selectedGenres.contains(genre)) {
      setState(() {
        print("REMOVE GENRE");
        widget.registrationData.selectedGenres.remove(genre);
      });
    } else {
      if (widget.registrationData.selectedGenres.length < 4) {
        setState(() {
          print("ADD GENRE");
          widget.registrationData.selectedGenres.add(genre);
        });
      }
    }
  }
}
