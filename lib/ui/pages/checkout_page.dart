part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSeatPage(widget.ticket));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  User user = (userState as UserLoaded).user;

                  return Column(
                    children: [
                      // * Arrow, Title Page
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        height: 56,
                        child: Stack(
                          children: [
                            // * Arrow
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToSeatPage(widget.ticket));
                                },
                              ),
                            ),
                            // * Title Page
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Checkout\nMovie',
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // * Movie Detail
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // * Poster
                          Container(
                            width: 70,
                            height: 90,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageBaseURL +
                                    'w342' +
                                    widget.ticket.movieDetail.posterPath),
                              ),
                            ),
                          ),
                          // * Title, Genres, Rating
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // * Title
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    70 -
                                    20,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: blackTextFont.copyWith(fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 6),
                              // * Genres
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    70 -
                                    20,
                                child: Text(
                                  widget.ticket.movieDetail.genresAndLanguage,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: greyTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(height: 6),
                              // * Rating
                              RatingStars(
                                voteAverage:
                                    widget.ticket.movieDetail.voteAverage,
                                color: accentColor3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // * Divider
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          color: Color(0xFFE4E4E4),
                          thickness: 1,
                        ),
                      ),
                      // * ID ORDER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ID Order',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.ticket.bookingCode,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans().copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      // * Cinema
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Cinema',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Text(
                              widget.ticket.theater.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.openSans().copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      // * Date & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date & Time',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.ticket.time.dateAndTime,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans().copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      // * Seat Numbers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seat Numbers',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Text(
                              widget.ticket.seatsInString,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.openSans().copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      // * Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${NumberFormat.currency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                              symbol: 'Rp ',
                            ).format(25000)} x ${widget.ticket.seats.length}',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans().copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      // * Fee
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fee',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${NumberFormat.currency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                              symbol: 'Rp ',
                            ).format(1500)} x ${widget.ticket.seats.length}',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans().copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      // * Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                              symbol: 'Rp ',
                            ).format(total),
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans().copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // * Divider
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          color: Color(0xFFE4E4E4),
                          thickness: 1,
                        ),
                      ),
                      // * Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Wallet',
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                              symbol: 'Rp ',
                            ).format(user.balance),
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans().copyWith(
                              color: (user.balance >= total)
                                  ? Color(0xFF3E9D9D)
                                  : Color(0xFFFF5C83),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // * Next Button
                      Container(
                        width: 250,
                        height: 45,
                        margin: EdgeInsets.only(top: 36, bottom: 45),
                        child: RaisedButton(
                          elevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          hoverElevation: 0,
                          child: Text(
                            (user.balance >= total)
                                ? 'Checkout Now'
                                : 'Top Up My Wallet',
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: (user.balance >= total)
                              ? Color(0xFF3E9D9D)
                              : mainColor,
                          onPressed: () {
                            if (user.balance >= total) {
                              // * Uang Cukup
                              FlutixTransaction transaction = FlutixTransaction(
                                userID: user.id,
                                title: widget.ticket.movieDetail.title,
                                subtitle: widget.ticket.theater.name,
                                amount: -total,
                                time: DateTime.now(),
                                picture: widget.ticket.movieDetail.posterPath,
                              );

                              context.bloc<PageBloc>().add(GoToSuccessPage(
                                  widget.ticket.copyWith(totalPrice: total),
                                  transaction));
                            } else {
                              // * Uang Tidak Cukup
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
