enum PymaentStatus { PENDING, COMPLETED, FAILED, COD }

enum MainCategory { SHOPPE, CARSPA, MECHANICAL, QUICKHELP }

enum OrderPage { RUNNING, HISTORY }

enum NotificationType { message, order, general, happyCode }

enum SocialMedia { facebook, email, whatsapp, instagram }

enum OrderStatus {
  ACTIVE,
  PROCESSING,
  CONFIRMED,
  DISPATCHED,
  FAILED,
  ACCEPTED,
  REASSIGNED,
  COMPLETED,
  REJECTED,
  CANCELLED,
  IN_PROGRESS,
  RETURN_REQUESTED,
  RETURN_ACCEPTED,
  RETURN_APPROVED,
  RETURN_REJECTED,
  RETURN_RECIEVED,
  REFUND_PROCESSING,
  REFUND_COMPLETED,
  REPLACEMENT_PROCESSING,
  REPLACEMENT_DISPATCHED,
  REPLACEMENT_COMPLETED,
  OTHER
}

class EnumConverter {
  static getCategoryString(MainCategory? category) {
    String? categoryString;
    switch (category) {
      case MainCategory.SHOPPE:
        categoryString = 'order';
        break;
      case MainCategory.CARSPA:
        categoryString = 'carspa-order';
        break;
      case MainCategory.MECHANICAL:
        categoryString = 'mechanical-order';
        break;
      case MainCategory.QUICKHELP:
        categoryString = 'quickhelp-order';
        break;
      case null:
      // TODO: Handle this case.
    }
    return categoryString;
  }

  static getStatusString(OrderPage? status) {
    String? statusString;

    switch (status) {
      case OrderPage.RUNNING:
        statusString = 'Running';
        break;
      case OrderPage.HISTORY:
        statusString = 'History';
        break;
      case null:
      // TODO: Handle this case.
    }
    return statusString;
  }

  static getCategoryEnum({required String categoryString}) {
    if (categoryString == 'order') {
      return MainCategory.SHOPPE;
    } else if (categoryString == 'carspa-order') {
      return MainCategory.CARSPA;
    } else if (categoryString == 'mechanical-order') {
      return MainCategory.MECHANICAL;
    } else if (categoryString == 'quickhelp-order') {
      return MainCategory.QUICKHELP;
    } else {
      return null;
    }
  }

  static getStatusEnum(String statusString) {
    if (statusString == "Running") {
      return OrderPage.RUNNING;
    } else if (statusString == 'History') {
      return OrderPage.HISTORY;
    } else {
      return null;
    }
  }

  static String convertEnumToStatus(OrderStatus orderStatus) {
    var status = "";
    switch (orderStatus) {
      case OrderStatus.ACCEPTED:
        status = "Accepted";
        break;
      case OrderStatus.PROCESSING:
        status = "Processing";
        break;
      case OrderStatus.ACTIVE:
        status = "Active";
        break;
      case OrderStatus.REASSIGNED:
        status = "Reassigned";
        break;
      case OrderStatus.REJECTED:
        return "Rejected";
      case OrderStatus.COMPLETED:
        status = "Completed";
        break;
      case OrderStatus.CANCELLED:
        status = "Cancelletd";
        break;
      case OrderStatus.IN_PROGRESS:
        status = "In_Progress";
        break;
      case OrderStatus.OTHER:
        status = "Other";
        break;
      case OrderStatus.CONFIRMED:
        status = "Confirmed";
        break;
      case OrderStatus.DISPATCHED:
        status = "Dispatched";
        break;
      case OrderStatus.FAILED:
        status = "Failed";
        break;
      case OrderStatus.RETURN_REQUESTED:
        status = "Return_Requested";
        break;
      case OrderStatus.RETURN_ACCEPTED:
        status = "Return_Policy";
        break;
      case OrderStatus.RETURN_APPROVED:
        status = "Return_Accepted";
        break;
      case OrderStatus.RETURN_REJECTED:
        status = "Return_Rejected";
        break;
      case OrderStatus.RETURN_RECIEVED:
        status = "Return_Recieved";
        break;
      case OrderStatus.REFUND_PROCESSING:
        status = "Refund_Processing";
        break;
      case OrderStatus.REFUND_COMPLETED:
        status = "Refund_Completed";
        break;
      case OrderStatus.REPLACEMENT_PROCESSING:
        status = "Replacement_Processing";
        break;
      case OrderStatus.REPLACEMENT_DISPATCHED:
        status = "Replacement_Dispatched";
        break;
      case OrderStatus.REPLACEMENT_COMPLETED:
        status = "Replacement_Completed";
        break;
    }
    return status;
  }

  static orderStatusToTitle(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.ACTIVE:
        return "Active";
      case OrderStatus.PROCESSING:
        return "Processing";
      case OrderStatus.ACCEPTED:
        return "Accepted";
      case OrderStatus.REASSIGNED:
        return "Re Assigned";
      case OrderStatus.COMPLETED:
        return "Completed";
      case OrderStatus.REJECTED:
        return "Rejected";
      case OrderStatus.CANCELLED:
        return "Cancelled";
      case OrderStatus.IN_PROGRESS:
        return "In Progress";
      case OrderStatus.OTHER:
        return "Other";
      case OrderStatus.CONFIRMED:
        return "Confirmed";
      case OrderStatus.DISPATCHED:
        return "Dispatched";
      case OrderStatus.FAILED:
        return "Failed";
      case OrderStatus.RETURN_REQUESTED:
        return "Return Requested";
      case OrderStatus.RETURN_ACCEPTED:
        return "Return Accepted";
      case OrderStatus.RETURN_APPROVED:
        return "Return Approved";
      case OrderStatus.RETURN_REJECTED:
        return "Return Rejected";
      case OrderStatus.RETURN_RECIEVED:
        return "Return Recieved";
      case OrderStatus.REFUND_PROCESSING:
        return "Refund Processing";
      case OrderStatus.REFUND_COMPLETED:
        return "Refund Completed";
      case OrderStatus.REPLACEMENT_PROCESSING:
        return "Replacement Processing";
      case OrderStatus.REPLACEMENT_DISPATCHED:
        return "Replacement Dispatched";
      case OrderStatus.REPLACEMENT_COMPLETED:
        return "Replacement Completed";
    }
  }

  static OrderStatus convertEnumFromStatus(String orderStatus) {
    if (orderStatus == "Active") {
      return OrderStatus.ACTIVE;
    } else if (orderStatus == "Processing") {
      return OrderStatus.PROCESSING;
    } else if (orderStatus == "Reassigned") {
      return OrderStatus.REASSIGNED;
    } else if (orderStatus == "Accepted") {
      return OrderStatus.ACCEPTED;
    } else if (orderStatus == "In_Progress") {
      return OrderStatus.IN_PROGRESS;
    } else if (orderStatus == "Rejected") {
      return OrderStatus.REJECTED;
    } else if (orderStatus == "Completed") {
      return OrderStatus.COMPLETED;
    } else if (orderStatus == "Cancelled") {
      return OrderStatus.CANCELLED;
    } else if (orderStatus == "Confirmed") {
      return OrderStatus.CONFIRMED;
    } else if (orderStatus == "Dispatched") {
      return OrderStatus.DISPATCHED;
    } else if (orderStatus == "Failed") {
      return OrderStatus.FAILED;
    } else if (orderStatus == "Refund_Completed") {
      return OrderStatus.REFUND_COMPLETED;
    } else if (orderStatus == "Refund_Processing") {
      return OrderStatus.REFUND_PROCESSING;
    } else if (orderStatus == "Replacement_Completed") {
      return OrderStatus.REPLACEMENT_COMPLETED;
    } else if (orderStatus == "Replacement_Dispatched") {
      return OrderStatus.REPLACEMENT_DISPATCHED;
    } else if (orderStatus == "Replacement_Processing") {
      return OrderStatus.REPLACEMENT_PROCESSING;
    } else if (orderStatus == "Return_Requested") {
      return OrderStatus.RETURN_REQUESTED;
    } else if (orderStatus == "Return_Accepted") {
      return OrderStatus.RETURN_ACCEPTED;
    } else if (orderStatus == "Return_Approved") {
      return OrderStatus.RETURN_APPROVED;
    } else if (orderStatus == "Return_Recieved") {
      return OrderStatus.RETURN_RECIEVED;
    } else if (orderStatus == "Return_Rejected") {
      return OrderStatus.RETURN_REJECTED;
    } else {
      return OrderStatus.OTHER;
    }
  }
}
