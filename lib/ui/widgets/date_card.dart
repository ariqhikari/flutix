part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final DateTime date;
  final Function onTap;

  DateCard(
    this.date, {
    this.isSelected = false,
    this.isEnabled = true,
    this.width = 70,
    this.height = 90,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date.shortDayName,
                style: ((!isEnabled)
                        ? greyTextFont
                        : (isSelected)
                            ? blackTextFont
                            : greyTextFont)
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 6),
              Text(
                date.day.toString(),
                style: GoogleFonts.openSans().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: (!isEnabled)
                      ? accentColor3
                      : (isSelected)
                          ? Colors.black
                          : accentColor3,
                ),
              ),
            ],
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
