part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  TicketPage({this.isExpiredTicket = false});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets;

  @override
  void initState() {
    super.initState();

    isExpiredTickets = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // * Content
        BlocBuilder<TicketBloc, TicketState>(
          builder: (_, ticketState) => Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 132, defaultMargin, 77),
            child: TicketViewer((!isExpiredTickets)
                ? ticketState.tickets
                    .where((ticket) => !ticket.time.isBefore(DateTime.now()))
                    .toList()
                : ticketState.tickets
                    .where((ticket) => ticket.time.isBefore(DateTime.now()))
                    .toList()),
          ),
        ),
        // * Header
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: accentColor1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 31),
                  child: Text(
                    'My Tickets',
                    style: whiteTextFont.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpiredTickets = !isExpiredTickets;
                            });
                          },
                          child: Text(
                            'Newest',
                            style: whiteTextFont.copyWith(
                              fontSize: 16,
                              color: (!isExpiredTickets)
                                  ? Colors.white
                                  : Color(0xFF67678E),
                            ),
                          ),
                        ),
                        Container(
                          height: 4,
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(top: 15),
                          color: (!isExpiredTickets)
                              ? accentColor2
                              : Colors.transparent,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpiredTickets = !isExpiredTickets;
                            });
                          },
                          child: Text(
                            'Oldest',
                            style: whiteTextFont.copyWith(
                              fontSize: 16,
                              color: (isExpiredTickets)
                                  ? Colors.white
                                  : Color(0xFF67678E),
                            ),
                          ),
                        ),
                        Container(
                          height: 4,
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(top: 15),
                          color: (isExpiredTickets)
                              ? accentColor2
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));

    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (_, index) => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: () {
            context
                .bloc<PageBloc>()
                .add(GoToTicketDetailPage(sortedTickets[index]));
          },
          child: Row(
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
                        sortedTickets[index].movieDetail.posterPath),
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
                      sortedTickets[index].movieDetail.title,
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
                      sortedTickets[index].movieDetail.genresAndLanguage,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: greyTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 6),
                  // * Theater
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        2 * defaultMargin -
                        70 -
                        20,
                    child: Text(
                      tickets[index].theater.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: greyTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
