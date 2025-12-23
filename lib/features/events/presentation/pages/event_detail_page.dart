import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_dialog.dart';
import '../../../tickets/presentation/providers/purchase_provider.dart';
import '../providers/events_provider.dart';
import '../widgets/event_detail_header.dart';
import '../widgets/event_detail_info.dart';
import '../widgets/event_detail_map.dart';
import '../widgets/event_detail_description.dart';
import '../widgets/event_detail_organizer.dart';
import '../widgets/event_detail_action_button.dart';

class EventDetailPage extends ConsumerWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    // Listen to purchase state
    ref.listen<PurchaseState>(purchaseProvider, (previous, next) {
      switch (next) {
        case PurchaseSuccess(:final ticket):
          // Dismiss loading dialog
          Navigator.of(context).pop();

          // Navigate to ticket purchased page
          context.go('/ticket-purchased/${ticket.id}');
        case PurchaseError(:final message):
          // Dismiss loading dialog
          Navigator.of(context).pop();

          // Show error
          AppDialogs.showErrorDialog(
            context: context,
            title: 'Error',
            message: message,
          );
        default:
          break;
      }
    });

    return Scaffold(
      body: eventAsync.when(
        data: (event) => Stack(
              children: [
                // Header with background image
                EventDetailHeader(event: event),

                // White overlay with content
                DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.6,
                  maxChildSize: 0.9,
                  snap: true,
                  snapSizes: const [0.6, 0.9],
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(24),
                        physics: const ClampingScrollPhysics(),
                        children: [
                          // Drag handle
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),

                          // Event info
                          EventDetailInfo(event: event),
                          const SizedBox(height: 24),

                          // Map placeholder
                          const EventDetailMap(),
                          const SizedBox(height: 24),

                          // Description section
                          EventDetailDescription(event: event),
                          const SizedBox(height: 24),

                          // Organizer info
                          EventDetailOrganizer(event: event),
                          const SizedBox(height: 32),

                          // Buy button
                          EventDetailActionButton(
                            event: event,
                            onPressed: () => _showPurchaseDialog(context, ref, event),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    );
                  },
                ),

                // Back button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        loading:
            () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
        error:
            (error, stack) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text('Error: $error'),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, WidgetRef ref, event) {
    AppDialogs.showPurchaseDialog(
      context: context,
      eventName: event.name,
      price: event.formattedPrice,
      quantity: 1,
      onConfirm: () async {
        // Show loading dialog
        AppDialogs.showLoadingDialog(
          context: context,
          message: 'Procesando compra...',
        );

        // Purchase ticket
        await ref
            .read(purchaseProvider.notifier)
            .purchaseTicket(eventId: event.id, quantity: 1);
      },
    );
  }
}
