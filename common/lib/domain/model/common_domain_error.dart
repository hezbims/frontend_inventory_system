sealed class CommonDomainError {}

/// Unable to reach external service may due to connectivity error
class NotReachedError extends CommonDomainError {}

class UnknownAppError extends CommonDomainError {}