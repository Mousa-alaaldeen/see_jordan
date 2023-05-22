// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_1/shared/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../models/data_model.dart';
import '../style/icon_broken.dart';

Widget deffaultButton({
  double width = double.infinity,
  double height = 50,
  required VoidCallback? function,
  required String? text,
  bool isUpperCase = true,
  Color textColor = Colors.white,
  double fontSize = 15.0,
  double radius = 7,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: defaultColor2,
      ),
      width: width,
      child: MaterialButton(
        height: height,
        onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
// Widget deffaultFooormField({
//   required TextEditingController controller,
//   TextInputType? type,
//   bool isPassword = false,
//   VoidCallback? onTap,
//   final FormFieldValidator<String>? validator,
//   void Function(String)? onChanged,
//   required String labelText,
//   required IconData? prefixIcon,
//   IconData? suffixIcon,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       onTap: onTap,
//       validator: validator,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         border: const OutlineInputBorder(),
//         labelText: labelText,
//         prefixIcon: Icon(prefixIcon),
//         suffixIcon: Icon(suffixIcon),
//       ),
//     );

Widget deffaultFormField(
        {required TextEditingController? controller,
        TextInputType? type,
        bool isPassword = false,
        IconData? prefix,
        IconData? suffix,

        //@required var validatee,
        //@required FormFieldValidator? validate,
        final FormFieldValidator<String>? validate,
        VoidCallback? suffixPressed,
        VoidCallback? onTap,
        bool isClickable = true,
        ValueChanged<String>? onFieldSubmitted}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        // hintStyle: GoogleFonts.josefinSans(
        //   textStyle: const TextStyle(
        //     color: Color(0xffc5d2e1),
        //     fontWeight: FontWeight.w400,
        //     fontSize: 20,
        //   ),
        // ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffix)),
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
    );
Widget deffaultTextButton({
  required VoidCallback? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
            color: defaultColor2,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget myDivider() => Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );
void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToasteColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { sUCCESS, eRORR, wORNING }

Color choseToasteColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.sUCCESS:
      color = Colors.green;
      break;
    case ToastState.eRORR:
      color = Colors.red;
      break;
    case ToastState.wORNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget deffaultListTitle({
  required String title,
  required IconData icon,
  Color colorIcon = Colors.black,
  Color colorText = Colors.black,
}) =>
    ListTile(
      leading: DecoratedIcon(
        icon: Icon(icon, color: colorIcon),
      ),
      title: Text(
        title,
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
            color: colorText,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
    );

// ///
// Widget bulidProductsItem(model, context, {bool isOldPrice = true}) => Container(
//       margin: const EdgeInsets.all(20),
//       height: 120,
//       child: Row(
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               productImage(
//                 imageUrl: "${model.image}",
//               ),
//               /*Image(
//                 image: NetworkImage(
//                   "${model.image}",
//                 ),
//                 width: 120,
//                 height: 120,
//               ),*/
//               if (model.discount != 0 && isOldPrice)
//                 Container(
//                   padding: const EdgeInsets.all(5),
//                   color: Colors.red,
//                   child: const Text(
//                     "Discount",
//                     style: TextStyle(
//                         fontSize: 8,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${model.name}",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     height: 1.3,
//                   ),
//                 ),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     Text(
//                       "${model.price}",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         height: 1.3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     if (model.discount != 0 && isOldPrice)
//                       Text(
//                         "${model.oldPrice}",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                           height: 1.3,
//                           decoration: TextDecoration.lineThrough,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     const Spacer(),
//                     IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context)
//                               .changeCartData(productId: model.id!);
//                           print(model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor:
//                               ShopCubit.get(context).cartProducts[model.id]!
//                                   ? Colors.red
//                                   : Colors.grey,
//                           child: const Icon(
//                             Icons.shopping_cart,
//                             color: Colors.white,
//                           ),
//                         )),
//                     IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context).changeFavoritesData(model.id!);
//                           print(model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor:
//                               ShopCubit.get(context).favorits[model.id]!
//                                   ? Colors.blue
//                                   : Colors.grey,
//                           child: const Icon(
//                             Icons.favorite_border,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

// productImage({
//   required String imageUrl,
//   double height = 120,
//   double width = 120,
// }) =>
//     CachedNetworkImage(
//       height: height,
//       width: width,
//       imageUrl: imageUrl,
//       placeholder: (context, url) => const CircularProgressIndicator(),
//       errorWidget: (context, url, error) => const Icon(Icons.error),
//     );

PreferredSizeWidget deffaultAppBar({
  required BuildContext context,
  Widget? title,
  List<Widget>? actions,
}) =>
    AppBar(
      elevation: 0,
      titleSpacing: 1.0,
      title: title,
      leading: IconButton(
        icon: Icon(
          IconBroken.arrowLeft_2,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
    );
Widget buildCategories(Data data, context, index, int x) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          // print(data.name);
          // print(data.categoryItems![index].title);
          print(index);
        },
        child: Container(
          width: 100,
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              data.name!,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  height: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ),
    );
Widget dataBuilder(list, context) => ConditionalBuilder(
      builder: (BuildContext context) => ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              buildCategories(list[index], context, index, index),
          separatorBuilder: (context, index) => SizedBox(
                width: 5,
              ),
          itemCount: list.length),
      condition: list.length > 0,
      fallback: (BuildContext context) =>
          Center(child: CircularProgressIndicator()),
    );
