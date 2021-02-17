part of 'pages.dart';

class SchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SchedulePage(this.movieDetail);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  Theater selectedTheater;
  int selectedTime;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Arrow
                  Container(
                    margin: EdgeInsets.only(top: 36, bottom: 20),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back, color: Colors.black),
                      onTap: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToMovieDetailPage(widget.movieDetail));
                      },
                    ),
                  ),
                  // * Choose Date
                  Text(
                    'Choose Date',
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 90,
                    margin: EdgeInsets.only(bottom: 24),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.only(right: 16),
                        child: DateCard(
                          dates[index],
                          isSelected: selectedDate == dates[index],
                          onTap: () {
                            setState(() {
                              selectedDate = dates[index];
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  // * Theater
                  generateTimeTable(context),
                  SizedBox(height: 30),
                  // * Next Button
                  Center(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => FloatingActionButton(
                        elevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        hoverElevation: 0,
                        backgroundColor:
                            (isValid) ? mainColor : Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: (isValid) ? Colors.white : Color(0xFFBEBEBE),
                        ),
                        onPressed: (isValid)
                            ? () {
                                context.bloc<PageBloc>().add(
                                      GoToSeatPage(
                                        Ticket(
                                            widget.movieDetail,
                                            selectedTheater,
                                            DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                selectedTime),
                                            randomAlphaNumeric(12)
                                                .toUpperCase(),
                                            [],
                                            (userState as UserLoaded).user.name,
                                            null),
                                      ),
                                    );
                              }
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateTimeTable(BuildContext context) {
    List<int> schedule = List.generate(7, (index) => 10 + (index * 2));
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(Text(
        theater.name,
        style: blackTextFont.copyWith(fontSize: 20),
      ));

      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(top: 16, bottom: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: schedule.length,
          itemBuilder: (_, index) => Container(
            width: 90,
            height: 50,
            margin: EdgeInsets.only(right: 16),
            child: SelectableBox(
              '${schedule[index]}:00',
              width: 90,
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid = true;
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
