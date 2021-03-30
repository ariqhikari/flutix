part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 136,
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 16),
                    child: Text(
                      'New Experience',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Text(
                    'Watch a new movie much\neasier than any before',
                    textAlign: TextAlign.center,
                    style: greyTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 45,
                    margin: EdgeInsets.only(top: 70, bottom: 20),
                    child: RaisedButton(
                      elevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      child: Text(
                        'Get Started',
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: mainColor,
                      onPressed: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(RegistrationData()));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: greyTextFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        child: Text(
                          'Sign In',
                          style: purpleTextFont.copyWith(fontSize: 14),
                        ),
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToLoginPage());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
