class GameDoneException implements Exception{
  String cause;
  GameDoneException(this.cause);
}