part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: accentColor1),
          SafeArea(child: Container(color: Color(0xFFF6F7F9))),
          ListView(),
          BottomNavbar(),
        ],
      ),
    );
  }
}
