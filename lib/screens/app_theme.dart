
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

/// ////////////////////////////////////////////////////////////////////////// ///
/// This dart file defines the Layout of the specific elements in our QuizApp ///
/// //////////////////////////////////////////////////////////////////////// ///



/// build Cards with the same look in different sizes
class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    Key key,
    @required this.padding,
    @required this.title,
    @required this.onTap,
    this.fontSize,
  });

  final VoidCallback onTap;
  final String title;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.75, 0),
        // 10% of the width, so there are ten blinds.
        colors: [Colors.white, Theme.of(context).primaryColorLight],
        // whitish to gray
        tileMode: TileMode.repeated, // repeats the gradient over the canvas
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          title: Padding(
            padding: padding,
            child: Wrap(
              // TODO: add circular percent indicator
              children: <Widget>[
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: (fontSize == null) ? 20.0 : fontSize, // if font size isn't defined, set it to 20
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// build the Navigation of the side menu drawer
class AppNavigationList extends StatelessWidget {

  const AppNavigationList({
    Key key,
    @required this.onTap,
    @required this.title,
});

  final VoidCallback onTap;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
      decoration: BoxDecoration(
        border: Border(
         bottom: BorderSide(
           color: Theme.of(context).primaryColor,
           width: 0.3,
         ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.0,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).accentColor,
        ),
        onTap: onTap,
      ),
    );
  }
}

/// This class defines the Layout of the TextFormFields
class AppTextFormField extends StatelessWidget {

  const AppTextFormField ({
    Key key,
    this.prefixIcon,
    this.suffixIcon,
    @required this.hintText,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  final Widget prefixIcon;
  final Widget suffixIcon;

  /// [hintText] will be shown inside of the formfield
  /// usage: explanation what the user is intended to type here
  final String hintText;

  /// [obscureText] toggles the visibility of the text,
  /// usage: hide sensitive data, e.g. passwords
  final bool obscureText;

  /// [onChanged] listens to changes of your text input
  /// usage: stores the typed input in a variable, so we can use it for login
  final void Function(String) onChanged;

  /// [validator] checks if the typed input corresponds to the expected value
  /// usage: you can check if your password has reached a minimum length
  final String Function(String) validator;

  final TextInputType keyboardType;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      obscureText: (obscureText == null) ? false : obscureText,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        contentPadding:
        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }
}






