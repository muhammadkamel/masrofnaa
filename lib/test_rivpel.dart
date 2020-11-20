import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Counter extends StateNotifier<int> {
  Counter() : super(5); // Starting number from 5
  void increment() => state++;
}

final counterProvider = StateNotifierProvider<Counter>((_) => Counter());

class MyHomei extends HookWidget {
  // const MyHomei({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = useProvider(counterProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: CounterWidget(count: count),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(counterProvider).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({@required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
