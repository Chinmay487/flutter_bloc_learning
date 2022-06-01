import 'dart:async';

enum CounterEvent{
  increment,decrement;
}

class CounterBloc{

  // StreanController for event i.e. increment event
  final _eventController = StreamController<CounterEvent>();
  Stream<CounterEvent> get eventSteam => _eventController.stream;
  Sink<CounterEvent> get eventSink => _eventController.sink;


  // StreamController to handle counter stream i.e. counter number updating
  final _counterController = StreamController<int>();
  Stream<int> get countStream => _counterController.stream;
  Sink<int> get countSink => _counterController.sink;


  int _counter = 0;

  CounterBloc(){
    eventSteam.listen((CounterEvent event) {
      // this will be called when new event will be added from sink
      if(event == CounterEvent.increment){
        // if event is increment event then this will be executed
        _counter += 1;

      }
      if(event == CounterEvent.decrement){
        // if event is decrement event then this will be executed
        _counter -= 1;
      }
      countSink.add(_counter);
    });
  }

  void dispose(){
    _eventController.close();
    _counterController.close();
  }

}

