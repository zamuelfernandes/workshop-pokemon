part of 'pokemon_cubit.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonSucess extends PokemonState {
  final List<Pokemon> pokelist;

  PokemonSucess({required this.pokelist});
}
class PokemonError extends PokemonState {
  final String message;
  
  PokemonError({required this.message});
}
