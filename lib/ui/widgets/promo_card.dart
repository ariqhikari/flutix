part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  PromoCard(this.promo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 23),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.title,
                    style: whiteTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    promo.subTitle,
                    style: GoogleFonts.raleway().copyWith(
                      color: Color(0xFFA99BE3),
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OFF ',
                    style: yellowNumberFont.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${promo.discount}%',
                    style: yellowNumberFont.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (rectangle) {
            return LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent,
              ],
            ).createShader(
              Rect.fromLTRB(0, 0, 77.5, 80),
            );
          },
          child: SizedBox(
            width: 77.5,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.asset('assets/reflection2.png'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (rectangle) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.transparent,
                ],
              ).createShader(
                Rect.fromLTRB(0, 0, 96, 40),
              );
            },
            child: SizedBox(
              width: 96,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                ),
                child: Image.asset('assets/reflection1.png'),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (rectangle) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.transparent,
                ],
              ).createShader(
                Rect.fromLTRB(0, 0, 53, 26),
              );
            },
            child: SizedBox(
              width: 53,
              height: 26,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                ),
                child: Image.asset('assets/reflection3.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
