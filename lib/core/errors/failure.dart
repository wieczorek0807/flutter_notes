abstract class Failure {}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message);
}
