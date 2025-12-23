// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myTicketsHash() => r'946a0d3f4ccfee460e9c4bbc78dd50f43acd94b4';

/// See also [myTickets].
@ProviderFor(myTickets)
final myTicketsProvider = AutoDisposeFutureProvider<List<TicketModel>>.internal(
  myTickets,
  name: r'myTicketsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$myTicketsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyTicketsRef = AutoDisposeFutureProviderRef<List<TicketModel>>;
String _$ticketDetailHash() => r'0e9cce2f13aa99a3150dec1e7a45b97516f24d96';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [ticketDetail].
@ProviderFor(ticketDetail)
const ticketDetailProvider = TicketDetailFamily();

/// See also [ticketDetail].
class TicketDetailFamily extends Family<AsyncValue<TicketModel>> {
  /// See also [ticketDetail].
  const TicketDetailFamily();

  /// See also [ticketDetail].
  TicketDetailProvider call(String ticketId) {
    return TicketDetailProvider(ticketId);
  }

  @override
  TicketDetailProvider getProviderOverride(
    covariant TicketDetailProvider provider,
  ) {
    return call(provider.ticketId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ticketDetailProvider';
}

/// See also [ticketDetail].
class TicketDetailProvider extends AutoDisposeFutureProvider<TicketModel> {
  /// See also [ticketDetail].
  TicketDetailProvider(String ticketId)
    : this._internal(
        (ref) => ticketDetail(ref as TicketDetailRef, ticketId),
        from: ticketDetailProvider,
        name: r'ticketDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$ticketDetailHash,
        dependencies: TicketDetailFamily._dependencies,
        allTransitiveDependencies:
            TicketDetailFamily._allTransitiveDependencies,
        ticketId: ticketId,
      );

  TicketDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ticketId,
  }) : super.internal();

  final String ticketId;

  @override
  Override overrideWith(
    FutureOr<TicketModel> Function(TicketDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TicketDetailProvider._internal(
        (ref) => create(ref as TicketDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ticketId: ticketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TicketModel> createElement() {
    return _TicketDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketDetailProvider && other.ticketId == ticketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ticketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TicketDetailRef on AutoDisposeFutureProviderRef<TicketModel> {
  /// The parameter `ticketId` of this provider.
  String get ticketId;
}

class _TicketDetailProviderElement
    extends AutoDisposeFutureProviderElement<TicketModel>
    with TicketDetailRef {
  _TicketDetailProviderElement(super.provider);

  @override
  String get ticketId => (origin as TicketDetailProvider).ticketId;
}

String _$eventForTicketHash() => r'f52ccacc6676a79bf16a5fc44f5d83da34f44205';

/// Helper provider to get event details for a given eventId
/// Use this in ticket widgets to fetch event info
///
/// Copied from [eventForTicket].
@ProviderFor(eventForTicket)
const eventForTicketProvider = EventForTicketFamily();

/// Helper provider to get event details for a given eventId
/// Use this in ticket widgets to fetch event info
///
/// Copied from [eventForTicket].
class EventForTicketFamily extends Family<AsyncValue<dynamic>> {
  /// Helper provider to get event details for a given eventId
  /// Use this in ticket widgets to fetch event info
  ///
  /// Copied from [eventForTicket].
  const EventForTicketFamily();

  /// Helper provider to get event details for a given eventId
  /// Use this in ticket widgets to fetch event info
  ///
  /// Copied from [eventForTicket].
  EventForTicketProvider call(String eventId) {
    return EventForTicketProvider(eventId);
  }

  @override
  EventForTicketProvider getProviderOverride(
    covariant EventForTicketProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventForTicketProvider';
}

/// Helper provider to get event details for a given eventId
/// Use this in ticket widgets to fetch event info
///
/// Copied from [eventForTicket].
class EventForTicketProvider extends AutoDisposeFutureProvider<dynamic> {
  /// Helper provider to get event details for a given eventId
  /// Use this in ticket widgets to fetch event info
  ///
  /// Copied from [eventForTicket].
  EventForTicketProvider(String eventId)
    : this._internal(
        (ref) => eventForTicket(ref as EventForTicketRef, eventId),
        from: eventForTicketProvider,
        name: r'eventForTicketProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$eventForTicketHash,
        dependencies: EventForTicketFamily._dependencies,
        allTransitiveDependencies:
            EventForTicketFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventForTicketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(EventForTicketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventForTicketProvider._internal(
        (ref) => create(ref as EventForTicketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _EventForTicketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventForTicketProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventForTicketRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventForTicketProviderElement
    extends AutoDisposeFutureProviderElement<dynamic>
    with EventForTicketRef {
  _EventForTicketProviderElement(super.provider);

  @override
  String get eventId => (origin as EventForTicketProvider).eventId;
}

String _$purchaseHash() => r'53eae243b5c11fd0fe833ede6186097f680a57d3';

/// See also [Purchase].
@ProviderFor(Purchase)
final purchaseProvider =
    AutoDisposeNotifierProvider<Purchase, PurchaseState>.internal(
      Purchase.new,
      name: r'purchaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$purchaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Purchase = AutoDisposeNotifier<PurchaseState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
