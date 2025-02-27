import 'package:flutter/material.dart';
import 'package:router_module/config/router_locator.dart';
import 'package:router_module/router/asd_router.dart';
import 'package:shared_module/presentation/widgets/errors/popover.dart';
import 'package:shared_module/utils/extensions/context_extensions.dart';

enum ErrorType { somethingWentWrong }

class ErrorBottomSheet {
  static void showErrorModal(
    BuildContext context,
    ErrorType errorType,
    VoidCallback? callback,
    VoidCallback? closeCallback,
  ) {
    final IconData iconData;
    final String title;
    final String description;

    switch (errorType) {
      case ErrorType.somethingWentWrong:
        iconData = Icons.error_outline;
        title = context.l10nShared.something_went_wrong_title;
        description = context.l10nShared.try_again_later_description;
        break;
    }

    _showModalBottomSheet(
      context,
      iconData,
      title,
      description,
      callback,
      closeCallback,
      errorType,
    );
  }

  static void _showModalBottomSheet(
    BuildContext context,
    IconData iconData,
    String title,
    String description,
    VoidCallback? callback,
    VoidCallback? closeCallback,
    ErrorType errorType,
  ) {
    showModalBottomSheet<int>(
      context: context,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return Popover(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            width: MediaQuery.sizeOf(context).width,
            height: 253,
            child: _buildContentColumn(
              context,
              iconData,
              title,
              description,
              callback,
              closeCallback,
              errorType,
            ),
          ),
        );
      },
    );
  }

  static Column _buildContentColumn(
    BuildContext context,
    IconData iconData,
    String title,
    String description,
    VoidCallback? callback,
    VoidCallback? closeCallback,
    ErrorType errorType,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildSomethingWentWrongImage(iconData),
              ),
            ),
            _buildCloseButton(callback),
          ],
        ),
        Column(
          children: [
            _buildErrorTitle(context, title),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildErrorDescription(description),
            ),
          ],
        ),
        _buildErrorButton(context, callback),
      ],
    );
  }

  static Widget _buildCloseButton(VoidCallback? callback) {
    return Expanded(
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed:
              () =>
                  callback == null
                      ? routerLocator<AsdRouter>().pop()
                      : callback(),
        ),
      ),
    );
  }

  static Icon _buildSomethingWentWrongImage(IconData iconData) {
    return Icon(iconData, size: 80);
  }

  static Text _buildErrorTitle(BuildContext context, String title) {
    return Text(title, style: context.theme.textTheme.titleMedium);
  }

  static Text _buildErrorDescription(String description) {
    return Text(description, textAlign: TextAlign.justify);
  }

  static TextButton _buildErrorButton(
    BuildContext context,
    VoidCallback? callback,
  ) {
    return TextButton(
      child: Text(
        context.l10nShared.understood_button_text,
        style: context.theme.textTheme.labelLarge,
      ),
      onPressed:
          () =>
              callback == null ? routerLocator<AsdRouter>().pop() : callback(),
    );
  }
}
