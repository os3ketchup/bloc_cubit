import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterEvent>(
      (event, emit) {
        switch (event) {
          case CounterEvent.increment:
            emit(state + 1);
            break;
          case CounterEvent.decrement:
            emit(state - 1);
            break;
        }
      },
    );
  }
}

Future<void> main() async {
  final bloc = CounterBloc();
  final streamSubscription = bloc.stream.listen(print);
  bloc.add(CounterEvent.increment);
  bloc.add(CounterEvent.decrement);

  await Future.delayed(Duration.zero);
  await streamSubscription.cancel();
  await bloc.close();
}
