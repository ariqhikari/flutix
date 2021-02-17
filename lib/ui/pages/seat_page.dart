part of 'pages.dart';

class SeatPage extends StatefulWidget {
  final Ticket ticket;

  SeatPage(this.ticket);

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .bloc<PageBloc>()
            .add(GoToSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  // * Arrow & Movie Detail
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // * Arrow
                        Container(
                          child: GestureDetector(
                            child: Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToSchedulePage(widget.ticket.movieDetail));
                            },
                          ),
                        ),
                        // * Movie Detail
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                widget.ticket.movieDetail.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: blackTextFont.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageBaseURL +
                                      'w154' +
                                      widget.ticket.movieDetail.backdropPath),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // * Cinema Screen
                  Container(
                    width: 277,
                    height: 84,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/screen.png'),
                      ),
                    ),
                  ),
                  // * Seats
                  generateSeats(context),
                  // * Info Seat
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // * Available
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE4E4E4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Text(
                            'Available',
                            style: greyTextFont.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      // * Booked
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Text(
                            'Booked',
                            style: greyTextFont.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      // * Selected
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: accentColor2,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Text(
                            'Selected',
                            style: greyTextFont.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // * Next Button
                  Center(
                    child: FloatingActionButton(
                      elevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      backgroundColor: (widget.ticket.seats.length > 0)
                          ? mainColor
                          : Color(0xFFE4E4E4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: (widget.ticket.seats.length > 0)
                            ? Colors.white
                            : Color(0xFFBEBEBE),
                      ),
                      onPressed: (widget.ticket.seats.length > 0)
                          ? () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToCheckoutPage(widget.ticket));
                            }
                          : null,
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateSeats(BuildContext context) {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (var i = 0; i < numberOfSeats.length; i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(
            bottom: (i != numberOfSeats.last - 1 ? 16 : 23),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              numberOfSeats[i],
              (index) => Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(
                  right: (index < numberOfSeats[i] - 1 ? 16 : 0),
                ),
                child: SelectableBox(
                  '${String.fromCharCode(i + 65)}${index + 1}',
                  width: 40,
                  height: 40,
                  textStyle: GoogleFonts.openSans().copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  isEnabled: index != 0,
                  isSelected: widget.ticket.seats
                      .contains('${String.fromCharCode(i + 65)}${index + 1}'),
                  onTap: () {
                    onSelectSeat('${String.fromCharCode(i + 65)}${index + 1}');
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(children: widgets);
  }

  void onSelectSeat(String seat) {
    if (widget.ticket.seats.contains(seat)) {
      setState(() {
        widget.ticket.seats.remove(seat);
      });
    } else {
      setState(() {
        widget.ticket.seats.add(seat);
      });
    }
  }
}
