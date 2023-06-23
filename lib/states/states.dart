abstract class ChangState<State> {}

class InitialState extends ChangState {}

class SetTokenState extends ChangState {}

class DatabaseInitialState extends ChangState {}

class DatabaseGetState extends ChangState {}

class DatabaseAddState extends ChangState {}

class DatabaseDeleteState extends ChangState {}

class DatabaseUpdateState extends ChangState {}

class SetMailTextState extends ChangState {}

class SetPassTextState extends ChangState {}

class SetIsAuthenticatedState extends ChangState {}