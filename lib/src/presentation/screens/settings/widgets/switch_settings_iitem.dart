import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/common/platform_switch.dart';

class SwitchSettingsItem extends StatelessWidget {
  const SwitchSettingsItem({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final Widget title;
  final bool value;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return PlatformListTile(
      title: title,
      trailing: PlatformSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
