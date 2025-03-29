import 'package:reflectable/reflectable.dart';
import 'package:wrapper/src/http/managers/manager.dart';
import 'package:runtime_type/runtime_type.dart';

// Define reflector with needed capabilities
class MyReflector extends Reflectable {
  const MyReflector()
    : super(
        instanceInvokeCapability,
        declarationsCapability,
        typeCapability,
        metadataCapability,
      );
}

const myReflector = MyReflector();

@myReflector
mixin ToStringHelper {
  String defaultToString() => super.toString();

  @override
  String toString() {
    return stringifyInstance(myReflector.reflect(this));
  }
}

final _stringifyStack = <Object?>[];

String stringifyInstance(InstanceMirror mirror) {
  final instance = mirror.reflectee;
  final existingIndex = _stringifyStack.indexOf(instance);
  if (existingIndex >= 0) {
    return '<Recursive #$existingIndex>';
  }
  _stringifyStack.add(instance);

  final type = mirror.type.simpleName;
  final buffer = StringBuffer('$type(\n');

  // Get all instance getters
  final declarations = mirror.type.instanceMembers;
  final getters = declarations.values.where(
    (declaration) => declaration.isGetter,
  );

  const blockedGetters = {'manager', 'hashCode', 'runtimeType'};

  final outputtedGetters =
      getters.where((getter) {
        final name = getter.simpleName;
        return !name.startsWith('_') &&
            !blockedGetters.contains(name) &&
            !_isReadOnlyManager(mirror, getter);
      }).toList();

  if (outputtedGetters.isEmpty) {
    _stringifyStack.removeLast();
    return 'Instance of $type';
  }

  outputtedGetters.sort((a, b) {
    final aName = a.simpleName;
    final bName = b.simpleName;

    if (aName == 'id') return -1;
    if (bName == 'id') return 1;
    return aName.compareTo(bName);
  });

  for (final getter in outputtedGetters) {
    late final String representation;
    try {
      final value = mirror.invokeGetter(getter.simpleName);
      representation = value.toString();
    } catch (e) {
      representation = '<$e>';
    }

    buffer.write('  ${getter.simpleName}: ');
    buffer.write(representation.replaceAll('\n', '\n  '));
    buffer.writeln(',');
  }

  buffer.write(')');
  _stringifyStack.removeLast();
  return buffer.toString();
}

bool _isReadOnlyManager(InstanceMirror mirror, MethodMirror getter) {
  try {
    final returnType = getter.returnType;
    if (returnType is ClassMirror) {
      return returnType.isSubtypeOf(
        myReflector.reflectType(ReadOnlyManager) as ClassMirror,
      );
    }
    return false;
  } catch (e) {
    return false;
  }
}
