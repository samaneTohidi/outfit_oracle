import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/models/detail_view_model.dart';
import 'package:outfit_oracle/screens/info/cubit/info_cubit.dart';

// Create cubit with Freezed
// Write states
// Write cubit
// read cubit fun in build
// Wrap Screen with BlocProvider
// use BlocConsumer or builder

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<InfoCubit>().getInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('sam'),
      ),
      body: BlocConsumer<InfoCubit, InfoState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return state.when(
              initial: () => initial(),
              loading: loading,
              loaded: (items) => loaded(items),
              error: error);
        },
      ),
    );
  }

  Widget initial() {
    return const Center(
      child: Text('load info'),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget loaded(DetailViewModel detail) {
    return Center(
      child: Text('Loaded: ${detail.collection?.title}'),
    );
  }
  Widget error() {
    return const Center(
      child: Text('An error occurred'),
    );
  }
}
