// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/pokemon.dart';
import '../repositories/pokemon_repository.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitial());

  Future<void> fetchPokemonList() async {
    emit(PokemonLoading());
    try {
      List<Pokemon> pokeList = await PokemonRepository.fetchPokemonList();
      emit(PokemonSucess(pokelist: pokeList));
    } catch (e) {
      emit(PokemonError(message: e.toString()));
    }
  }
}
