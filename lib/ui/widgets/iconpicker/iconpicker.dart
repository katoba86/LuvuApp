
import 'package:flutter/material.dart';
import 'package:luvutest/ui/shared/ui_helpers.dart';
import 'IconPicker/iconPicker.dart';
import 'IconPicker/searchBar.dart';





class FlutterIconPicker {
  static Future<IconData> showIconPicker(BuildContext context,
      {


        bool searchBar = false,
        /// Size for every icon as [double]
        /// Default: `40.0`
        double iconSize = 40,

        /// The Dialog shape for the picker
        /// Defaults to AlertDialog shape
        ShapeBorder iconPickerShape,

        /// The title for the Picker.
        /// Sits above the [SearchBar] and [Icons].
        /// Defaults to:
        /// ```dart
        ///   const Text('Pick an icon')
        /// ```
        Widget title = const Text('Pick an icon'),

        /// The child for the Widget `FlatButton`, which closes the dialog.
        /// Sits underneeth everything.
        /// Defaults to:
        /// ```dart
        ///   const Text(
        ///     'Close',
        ///     textScaleFactor: 1.25,
        ///   ),
        /// ```
        Widget closeChild = const Text(
          'Close',
          textScaleFactor: 1.25,
        ),

        /// The Text to show when Searchbar-Term is empty
        /// Default: `Search`
        String searchHintText = 'Search',

        /// The text to show when no results where found for the search term
        /// Default: `No results for:`
        String noResultsText = 'No results for:',

        /// The mode which Icons to show
        /// Modes: `material`, `cupertino` or `custom`
        /// Default: `IconPack.material`
        Map<String, IconData> icons
      }) async {
    IconData iconPicked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: iconPickerShape,
            title: title,
            content: Container(
              constraints: BoxConstraints(maxHeight: 350, minWidth: 450),
              child: Column(children: <Widget>[


                (searchBar)?SearchBar(
                    icons: icons, searchHintText: searchHintText):verticalSpaceTiny,


                Flexible(
                    child: IconPicker(
                        icons: icons,
                        noResultsText: noResultsText,
                        iconSize: iconSize))
              ]),
            ),
            actions: [
              FlatButton(
                padding: const EdgeInsets.only(right: 20),
                onPressed: () => Navigator.of(context).pop(),
                child: closeChild,
              )
            ]);
      },
    );

    SearchBar.searchTextController.clear();

    if (iconPicked != null) {
      return iconPicked;
    }
    return null;
  }


  static String iconToString(IconData icon){

  }
  static IconData StringToIcon(String iconName){

  }
}