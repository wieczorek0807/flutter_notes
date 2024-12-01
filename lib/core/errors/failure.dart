abstract class Failure {
  final String message;

  Failure(this.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class RepositoryFailure extends Failure {
  RepositoryFailure(super.message);
}

class UseCaseFailure extends Failure {
  UseCaseFailure(super.message);
}
