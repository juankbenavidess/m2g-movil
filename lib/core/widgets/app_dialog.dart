import 'package:flutter/material.dart';

/// Generic reusable dialog widget
/// Can be used for confirmations, alerts, info, etc.
class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final IconData? icon;
  final Color? iconColor;
  final bool isDanger;
  final bool showCancel;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText,
    this.confirmText = 'Confirmar',
    this.onCancel,
    required this.onConfirm,
    this.confirmColor,
    this.icon,
    this.iconColor,
    this.isDanger = false,
    this.showCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveConfirmColor = confirmColor ??
        (isDanger ? Colors.red : Colors.orange);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: icon != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: iconColor ?? effectiveConfirmColor,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (showCancel)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
            child: Text(
              cancelText ?? 'Cancelar',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveConfirmColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            confirmText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

/// Helper class to show dialogs easily
class AppDialogs {
  /// Show a purchase confirmation dialog
  static Future<void> showPurchaseDialog({
    required BuildContext context,
    required String eventName,
    required String price,
    required int quantity,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Comprar ticket',
        content: '¿Confirmar compra de $quantity ticket${quantity > 1 ? 's' : ''} para "$eventName"?\n\nTotal: $price',
        confirmText: 'Confirmar compra',
        icon: Icons.confirmation_number,
        iconColor: Colors.orange,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  /// Show a success dialog
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Aceptar',
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: message,
        confirmText: confirmText,
        icon: Icons.check_circle,
        iconColor: Colors.green,
        showCancel: false,
        onConfirm: onConfirm ?? () {},
      ),
    );
  }

  /// Show an error dialog
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Entendido',
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: message,
        confirmText: confirmText,
        icon: Icons.error_outline,
        iconColor: Colors.red,
        showCancel: false,
        isDanger: true,
        onConfirm: onConfirm ?? () {},
      ),
    );
  }

  /// Show a loading dialog (non-dismissible)
  static void showLoadingDialog({
    required BuildContext context,
    String message = 'Cargando...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dismiss any dialog
  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}