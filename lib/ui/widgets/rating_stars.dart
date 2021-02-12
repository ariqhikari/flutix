part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;

  final Color color;

  final MainAxisAlignment rowMainAxisAlignment;

  RatingStars({
    this.voteAverage = 0,
    this.starSize = 20,
    this.fontSize = 12,
    this.color = Colors.white,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();
    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        MdiIcons.star,
        color: index < n ? accentColor2 : color.withOpacity(0.4),
        size: starSize,
      ),
    );

    widgets.add(SizedBox(width: 3));
    widgets.add(
      Text('$voteAverage / 10',
          style: GoogleFonts.openSans().copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color: color,
          )),
    );

    return Row(
      mainAxisAlignment: rowMainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}
