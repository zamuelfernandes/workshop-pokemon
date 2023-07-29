// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pokemon_cubit.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  late PokemonCubit _cubit;
  @override
  void initState() {
    _cubit = PokemonCubit()..fetchPokemonList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold,),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {
              _cubit.fetchPokemonList();
            },
          )
        ],
      ),
      body: BlocConsumer<PokemonCubit, PokemonState>(
        bloc: _cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PokemonError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          }
          if (state is PokemonSucess) {
            return ListView.builder(
              itemCount: state.pokelist.length,
              itemExtent: 66,
              itemBuilder: (context, index) {
                final pokemon = state.pokelist[index];
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 16),
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.network(
                      pokemon.img,
                    ),
                  ),
                  title: Text(pokemon.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(pokemon.type, ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}