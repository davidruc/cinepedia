import 'package:animate_do/animate_do.dart';
import 'package:cinepedia/config/helpers/human_formats.dart';
import 'package:cinepedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoveHorizontalListview extends StatefulWidget {
  const MoveHorizontalListview(
    {
      super.key, 
      required this.movies, 
      this.title, 
      this.subtitle, 
      this.loadNextPage
    });

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  @override
  State<MoveHorizontalListview> createState() => _MoveHorizontalListviewState();
}

class _MoveHorizontalListviewState extends State<MoveHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    
    super.initState();

    scrollController.addListener(() {
      if ( widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }

    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          if(widget.title != null || widget.subtitle != null)
          _Title(title: widget.title, subtitle: widget.subtitle),

        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              return FadeInRight(child: _SlideMovie(movie: widget.movies[index]));
            },
            ))

        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    this.title, 
    this.subtitle
  });

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container( 
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row( 
        children: [
          if ( title != null)
            Text(title!, style: titleStyle,),

          const Spacer(),

          if ( subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text( subtitle! ),
            ),
        ]
      ),
    );
  }
}


class _SlideMovie extends StatelessWidget {
  const _SlideMovie({ required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          //* Imagen
          SizedBox(
            width: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 180,
                height: 250,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child:CircularProgressIndicator(strokeWidth: 2)));
                  }
                  return GestureDetector(
                    onTap: () => context.push("/movie/${ movie.id}"),
                    child: FadeIn(child: child),
                  );
                  
                  
                },
              ),
            ),
          ),

          const SizedBox(height: 4),
          //* Titulo

          SizedBox(
            width: 145,
            height: 41,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                  movie.title,
                  maxLines: 2,
                  style: textStyles.titleSmall,
                                ),
                ),
              ]
            ),
          ),
          const SizedBox(height: 3),

          //* Raiting
          SizedBox(
            width: 145,
            child: Row(
              children: [
                Icon( Icons.star_half_outlined, color: Colors.yellow.shade800),
                Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                const Spacer(),
                Text( HumanFormats.number(movie.popularity), style: textStyles.bodySmall)
              ],
            ),
          )
        ],
      ),
    );
  }
}