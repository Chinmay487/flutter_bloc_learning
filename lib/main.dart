import 'package:flutter/material.dart';
import "./counter_block.dart";

void main(){
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BLoC App"),
        ),
        body: const SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final CounterBloc _counterBloc = CounterBloc();

  @override
  void dispose(){
    _counterBloc.dispose();
    super.dispose();
  }

  void incrementCounter(){
    _counterBloc.eventSink.add(CounterEvent.increment);
  }

  void decrementCounter(){
    _counterBloc.eventSink.add(CounterEvent.decrement);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<int>(
            initialData : 0,
            stream: _counterBloc.countStream,
            builder: (context,snapshot){
              final counter = snapshot.data;

              return Text("$counter times clicked");
            },
          ),
          ElevatedButton(
              onPressed: incrementCounter,
              child: const Text("Increment"),
          ),
          ElevatedButton(
            onPressed: decrementCounter,
              child: const Text("Decrement"),
          )
        ],
      ),
    );
  }
}
