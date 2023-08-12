import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_divider.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';

class PlatformSectionedList extends PlatformWidget {
  const PlatformSectionedList({
    required this.listSections,
    super.key,
  });

  final List<PlatformListSection> listSections;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return ListView.builder(
      itemCount: listSections.length,
      itemBuilder: (_, index) => CupertinoListSection(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        ),
        header: listSections[index].header,
        children: listSections[index].children,
      ),
    );
  }

  List<Widget> _mapListSectionsToWidgets() {
    final widgets = <Widget>[];
    for (var sectionIndex = 0;
        sectionIndex < listSections.length;
        sectionIndex++) {
      final header = listSections[sectionIndex].header;
      if (header != null) {
        final sectionHeader = Padding(
          padding: const EdgeInsets.only(left: 16),
          child: header,
        );
        widgets
          ..add(sectionHeader)
          ..add(const SizedBox(height: 8));
      }

      final numberOfWidgets = listSections[sectionIndex].children?.length ?? 0;
      for (var widgetIndex = 0; widgetIndex < numberOfWidgets; widgetIndex++) {
        widgets.add(
          listSections[sectionIndex].children?[widgetIndex] ?? Container(),
        );
        if (widgetIndex < numberOfWidgets - 1) {
          widgets.add(const PlatformDivider());
        }
      }

      if (sectionIndex < listSections.length - 1) {
        widgets.add(const SizedBox(height: 20));
      }
    }

    return widgets;
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return ListView(
      children: _mapListSectionsToWidgets(),
    );
  }
}

class PlatformListSection {
  const PlatformListSection({
    required this.header,
    required this.children,
  });

  final Widget? header;
  final List<Widget>? children;
}
