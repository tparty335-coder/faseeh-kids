import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_queue_item.freezed.dart';
part 'sync_queue_item.g.dart';

/// Sync queue item model — offline-first sync queue entry
/// Stores pending writes to be synced when connectivity returns
@freezed
class SyncQueueItem with _$SyncQueueItem {
  const factory SyncQueueItem({
    /// Unique queue item identifier
    required String id,

    /// Firestore collection name
    required String collection,

    /// Firestore document ID
    required String documentId,

    /// Data payload to sync
    required Map<String, dynamic> data,

    /// Timestamp when the item was queued
    required DateTime timestamp,

    /// Whether the item has been synced
    @Default(false) bool synced,
  }) = _SyncQueueItem;

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) =>
      _$SyncQueueItemFromJson(json);
}
