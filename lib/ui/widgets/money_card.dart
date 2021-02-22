part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final bool isSelected;
  final double width;
  final int amount;
  final Function onTap;

  MoneyCard({
    this.isSelected = false,
    this.width = 90,
    this.amount = 0,
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
        height: 66,
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        child: Center(
          child: Column(
            children: [
              Text(
                'IDR',
                style: greyTextFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: (isSelected) ? Colors.black : accentColor3,
                ),
              ),
              Text(
                '${NumberFormat.currency(
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: '',
                ).format(amount)}',
                style: whiteNumberFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: (isSelected) ? accentColor2 : Color(0xFFE4E4E4),
          ),
          color: (isSelected) ? accentColor2 : Colors.transparent,
        ),
      ),
    );
  }
}
