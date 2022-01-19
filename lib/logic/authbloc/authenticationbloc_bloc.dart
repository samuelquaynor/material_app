import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authenticationbloc_event.dart';
part 'authenticationbloc_state.dart';

class AuthenticationblocBloc extends Bloc<AuthenticationblocEvent, AuthenticationblocState> {
  AuthenticationblocBloc() : super(AuthenticationblocInitial()) {
    on<AuthenticationblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
