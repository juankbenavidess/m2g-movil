// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsHash() => r'3fa908f21adf10315cf5167e23b7be0b48d7cf1d';

/// See also [events].
@ProviderFor(events)
final eventsProvider = AutoDisposeFutureProvider<List<EventModel>>.internal(
  events,
  name: r'eventsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventsRef = AutoDisposeFutureProviderRef<List<EventModel>>;
String _$eventDetailHash() => r'1feb6232ba2175293b0cd205b869e5932209922e';

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

/// See also [eventDetail].
@ProviderFor(eventDetail)
const eventDetailProvider = EventDetailFamily();

/// See also [eventDetail].
class EventDetailFamily extends Family<AsyncValue<EventModel>> {
  /// See also [eventDetail].
  const EventDetailFamily();

  /// See also [eventDetail].
  EventDetailProvider call(String eventId) {
    return EventDetailProvider(eventId);
  }

  @override
  EventDetailProvider getProviderOverride(
    covariant EventDetailProvider provider,
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
  String? get name => r'eventDetailProvider';
}

/// See also [eventDetail].
class EventDetailProvider extends AutoDisposeFutureProvider<EventModel> {
  /// See also [eventDetail].
  EventDetailProvider(String eventId)
    : this._internal(
        (ref) => eventDetail(ref as EventDetailRef, eventId),
        from: eventDetailProvider,
        name: r'eventDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$eventDetailHash,
        dependencies: EventDetailFamily._dependencies,
        allTransitiveDependencies: EventDetailFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventDetailProvider._internal(
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
    FutureOr<EventModel> Function(EventDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventDetailProvider._internal(
        (ref) => create(ref as EventDetailRef),
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
  AutoDisposeFutureProviderElement<EventModel> createElement() {
    return _EventDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.eventId == eventId;
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
mixin EventDetailRef on AutoDisposeFutureProviderRef<EventModel> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventDetailProviderElement
    extends AutoDisposeFutureProviderElement<EventModel>
    with EventDetailRef {
  _EventDetailProviderElement(super.provider);

  @override
  String get eventId => (origin as EventDetailProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
