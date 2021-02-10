part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(bottom: 4),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Color(0xFFEBEFF6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/ic_${genre.toLowerCase()}.png'),
        ),
        Text(
          genre,
          textAlign: TextAlign.center,
          style: blackTextFont.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
