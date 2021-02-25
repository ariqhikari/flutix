part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  ComingSoonCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(8),
        image: (movie.posterPath == null)
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageBaseURL + 'w500' + movie.posterPath),
              ),
      ),
    );
  }
}
