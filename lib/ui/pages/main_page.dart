part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;

  MainPage({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavbarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavbarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavbarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: accentColor1,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Color(0xFFF6F7F9)),
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  bottomNavbarIndex = index;
                });
              },
              children: [
                MoviePage(),
                TicketPage(isExpiredTicket: widget.isExpired),
              ],
            ),
            createCustomBottomNavbar(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 46,
                height: 46,
                margin: EdgeInsets.only(bottom: 42),
                child: FloatingActionButton(
                  elevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  hoverElevation: 0,
                  backgroundColor: accentColor2,
                  child: Container(
                    width: 26,
                    height: 26,
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      MdiIcons.walletPlus,
                      color: Colors.black.withOpacity(0.54),
                    ),
                  ),
                  onPressed: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToTopUpPage(GoToMainPage(bottomNavBarIndex: 0)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createCustomBottomNavbar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavbarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.black,
              unselectedItemColor: Color(0xFFE5E5E5),
              currentIndex: bottomNavbarIndex,
              onTap: (index) {
                setState(() {
                  bottomNavbarIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text(
                    'New Movies',
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Container(
                    margin: EdgeInsetsDirectional.only(bottom: 6),
                    height: 20,
                    child: Image.asset(
                      (bottomNavbarIndex == 0)
                          ? 'assets/ic_movie.png'
                          : 'assets/ic_movie_grey.png',
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    'My Tickets',
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Container(
                    margin: EdgeInsetsDirectional.only(bottom: 6),
                    height: 20,
                    child: Image.asset(
                      (bottomNavbarIndex == 1)
                          ? 'assets/ic_tickets.png'
                          : 'assets/ic_tickets_grey.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class BottomNavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
