part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final TextStyle textStyle;
  final Function onTap;

  SelectableBox(
    this.text, {
    this.isSelected = false,
    this.isEnabled = true,
    this.width = 144,
    this.height = 60,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text ?? 'None',
            style: (textStyle ?? blackTextFont).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: (!isEnabled)
                ? Color(0xFFE4E4E4)
                : (isSelected)
                    ? accentColor2
                    : Color(0xFFE4E4E4),
          ),
          color: (!isEnabled)
              ? Color(0xFFE4E4E4)
              : (isSelected)
                  ? accentColor2
                  : Colors.transparent,
        ),
      ),
    );
  }
}
