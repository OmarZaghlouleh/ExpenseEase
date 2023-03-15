abstract class BaseUsecase<T, P> {
  T call(P p);
}

// T: Type
// P: Parameter

class Nothing {
  const Nothing();
}
