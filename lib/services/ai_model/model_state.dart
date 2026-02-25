sealed class ModelState {
  const ModelState();
}

final class Idle extends ModelState {
  const Idle();
}

final class Downloading extends ModelState {
  const Downloading(this.progress);
  final double progress;
}

final class Loading extends ModelState {
  const Loading();
}

final class Ready extends ModelState {
  const Ready();
}

final class Generating extends ModelState {
  const Generating();
}

final class Failed extends ModelState {
  const Failed(this.message);
  final String message;
}
