// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Subscoial FFI Binding
class RawSubsoical {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  RawSubsoical(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  RawSubsoical.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  int subsocial_dispatch(
    int port,
    ffi.Pointer<SharedBuffer> ptr,
  ) {
    return _subsocial_dispatch(
      port,
      ptr,
    );
  }

  late final _subsocial_dispatch_ptr =
      _lookup<ffi.NativeFunction<_c_subsocial_dispatch>>('subsocial_dispatch');
  late final _dart_subsocial_dispatch _subsocial_dispatch =
      _subsocial_dispatch_ptr.asFunction<_dart_subsocial_dispatch>();

  /// a no-op function that forces xcode to link to our lib.
  /// ## Safety
  /// lol
  void subsocial_link_me_plz() {
    return _subsocial_link_me_plz();
  }

  late final _subsocial_link_me_plz_ptr =
      _lookup<ffi.NativeFunction<_c_subsocial_link_me_plz>>(
          'subsocial_link_me_plz');
  late final _dart_subsocial_link_me_plz _subsocial_link_me_plz =
      _subsocial_link_me_plz_ptr.asFunction<_dart_subsocial_link_me_plz>();

  int subsoical_init_client(
    int port,
  ) {
    return _subsoical_init_client(
      port,
    );
  }

  late final _subsoical_init_client_ptr =
      _lookup<ffi.NativeFunction<_c_subsoical_init_client>>(
          'subsoical_init_client');
  late final _dart_subsoical_init_client _subsoical_init_client =
      _subsoical_init_client_ptr.asFunction<_dart_subsoical_init_client>();
}

/// Immutable View of Shared Buffer.
class SharedBuffer extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> buf;

  @ffi.Uint64()
  external int len;
}

typedef _c_subsocial_dispatch = ffi.Int32 Function(
  ffi.Int64 port,
  ffi.Pointer<SharedBuffer> ptr,
);

typedef _dart_subsocial_dispatch = int Function(
  int port,
  ffi.Pointer<SharedBuffer> ptr,
);

typedef _c_subsocial_link_me_plz = ffi.Void Function();

typedef _dart_subsocial_link_me_plz = void Function();

typedef _c_subsoical_init_client = ffi.Int32 Function(
  ffi.Int64 port,
);

typedef _dart_subsoical_init_client = int Function(
  int port,
);
