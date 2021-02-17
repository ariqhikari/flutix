part of 'services.dart';

class TicketServices {
  static CollectionReference _ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await _ticketCollection.document().setData({
      'movieID': ticket.movieDetail.id ?? '',
      'userID': id ?? '',
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().microsecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTickets(String userID) async {
    QuerySnapshot snapshot = await _ticketCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userID);

    List<Ticket> tickets = [];

    for (var document in documents) {
      MovieDetail movieDetail =
          await MovieServices.getDetailsMovie(document.data['movieID']);

      tickets.add(Ticket(
        movieDetail,
        Theater(document.data['theaterName']),
        DateTime.fromMillisecondsSinceEpoch(document.data['time']),
        document.data['bookingCode'],
        document.data['seats'].toString().split(','),
        document.data['name'],
        document.data['totalPrice'],
      ));
    }

    return tickets;
  }
}
