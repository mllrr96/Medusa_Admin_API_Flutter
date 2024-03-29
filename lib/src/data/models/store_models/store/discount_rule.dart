import 'index.dart';
import '../../../enum/enums.dart';
class DiscountRule {
  /// The discount rule's id
  ///
  /// Example: "dru_01F0YESMVK96HVX7N419E3CJ7C"
  final String? id;

  /// The type of the discount, can be fixed for discounts that reduce the price by a fixed amount, percentage for percentage reductions or free_shipping for shipping vouchers.
  final DiscountRuleType? type;

  /// A short description of the discount
  ///
  /// Example: "10 Percent"
  final String? description;

  /// The value that the discount represents; this will depend on the type of the discount
  ///
  /// Example: 10
  final int? value;

  /// The scope that the discount should apply to.
  final AllocationType? allocation;

  /// The details of the discount conditions associated with the rule. they can be used to limit when the discount can be used.
  final List<DiscountCondition>? conditions;

  /// The date with timezone at which the resource was created.
  final DateTime? createdAt;

  /// The date with timezone at which the resource was updated.
  final DateTime? updatedAt;

  /// The date with timezone at which the resource was deleted.
  final DateTime? deletedAt;

  /// An optional key-value map with additional details
  final Map<String, dynamic>? metadata;

  const DiscountRule({
    this.id,
    required this.type,
    this.description,
    required this.value,
    this.allocation,
    this.conditions,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory DiscountRule.fromJson(Map<String, dynamic> json) {
    List<DiscountCondition>? conditions;
    if (json['conditions'] != null) {
      conditions = <DiscountCondition>[];
      json['conditions'].forEach((e) => conditions!.add(DiscountCondition.fromJson(e)));
    }

    return DiscountRule(
      id: json['id'],
      type: DiscountRuleType.values.firstWhere((e) => e.value == (json['type'] ?? '')),
      description: json['description'],
      value: json['value'],
      conditions: conditions,
      allocation:
          AllocationType.values.where((e) => e.value == (json['allocation'])).firstOrNull ?? AllocationType.total,
      createdAt: DateTime.tryParse(json['created_at'] ?? '')?.toLocal(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '')?.toLocal(),
      deletedAt: DateTime.tryParse(json['deleted_at'] ?? '')?.toLocal(),
      metadata: json['metadata'],
    );
  }
  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    if (id != null) {
      json['id'] = id;
    }
    if (type != null) {
      json['type'] = type?.value;
    }

    if (description != null) {
      json['description'] = description;
    }
    json['value'] = value;

    if (allocation != null) {
      json['allocation'] = allocation?.value;
    }

    if (conditions != null) {
      json['conditions'] = conditions?.map((e) => e.toJson()).toList();
    }

    if (createdAt != null) {
      json['created_at'] = createdAt.toString();
    }

    if (updatedAt != null) {
      json['updated_at'] = updatedAt.toString();
    }

    if (deletedAt != null) {
      json['deleted_at'] = deletedAt.toString();
    }

    if (metadata != null) {
      json['metadata'] = metadata;
    }

    return json;
  }
}
