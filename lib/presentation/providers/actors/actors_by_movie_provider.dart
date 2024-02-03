import 'package:cinepedia/domain/entities/actor.dart';
import 'package:cinepedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepostory = ref.watch( actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActor: actorsRepostory.getActorsByMovie);
}

);


typedef GetActorCallBack = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorCallBack getActor;

  ActorsByMovieNotifier({required this.getActor}): super({});

  Future<void> loadActors(String movieId) async {
    if ( state[movieId] != null ) return; //*Así puedo evitar que si ya la tengo la vuelva a llamar
    final List<Actor> actor = await getActor(movieId);

    state = { ...state, movieId: actor };
  }

}