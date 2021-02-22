part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                User user = userState.user;

                return ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // * Arrow
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 30),
                          child: GestureDetector(
                            child: Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
                            },
                          ),
                        ),
                        // * User Profile
                        Center(
                          child: Column(
                            children: [
                              // * Image Profile
                              Container(
                                width: 120,
                                height: 120,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: (user.profilePicture == ''
                                        ? AssetImage('assets/user_pic.png')
                                        : NetworkImage(user.profilePicture)),
                                  ),
                                ),
                              ),
                              // * User Name
                              Text(
                                user.name,
                                style: blackTextFont.copyWith(fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text(
                                user.email,
                                style: greyTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        // * Edit Profile
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset("assets/edit_profile.png"),
                            ),
                            Text(
                              'Edit Profile',
                              style: blackTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin),
                        SizedBox(height: 16),
                        // * My Wallet
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset("assets/my_wallet.png"),
                            ),
                            Text(
                              'My Wallet',
                              style: blackTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin),
                        SizedBox(height: 16),
                        // * Change Language
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset("assets/language.png"),
                            ),
                            Text(
                              'Change Language',
                              style: blackTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin),
                        SizedBox(height: 16),
                        // * Help Centre
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset("assets/help_centre.png"),
                            ),
                            Text(
                              'Help Centre',
                              style: blackTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin),
                        SizedBox(height: 16),
                        // * Rate Flutix App
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset("assets/rate.png"),
                            ),
                            Text(
                              'Rate Flutix App',
                              style: blackTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin),
                        SizedBox(height: 16),
                        // * Sign Out
                        GestureDetector(
                          onTap: () {
                            context.bloc<UserBloc>().add(SignOut());
                            AuthServices.signOut();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  MdiIcons.logout,
                                  color: mainColor,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'Sign Out',
                                style: blackTextFont.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin),
                        SizedBox(height: 100),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                  child: SpinKitFadingCircle(
                    color: mainColor,
                    size: 50,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
