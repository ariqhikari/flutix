part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;

  RatingStars({
    this.voteAverage = 0,
    this.starSize = 20,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();
    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        MdiIcons.star,
        color: index < n ? accentColor2 : Colors.white.withOpacity(0.4),
        size: starSize,
      ),
    );

    widgets.add(SizedBox(width: 3));
    widgets.add(
      Text(
        '$voteAverage/10',
        style: whiteNumberFont.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}
