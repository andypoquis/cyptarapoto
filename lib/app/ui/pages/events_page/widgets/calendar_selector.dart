import 'package:cyptarapoto/app/controllers/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CalendarSelector extends GetView<EventsController> {
  const CalendarSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      maxLines: 1,
      readOnly: true,
      controller: controller.dispatchCalendarSelectorCnt,
      textAlignVertical: TextAlignVertical.center,
      onTap: () async {
        await initializeDateFormatting('es');
        DateTime today = DateTime.now();
        final selectedDate = await showOmniDateTimePicker(
          context: context,
          initialDate: today,
          firstDate: DateTime(2010),
          lastDate: today.add(const Duration(days: 3652)),
          is24HourMode: true,
          selectableDayPredicate: (DateTime day) {
            return day
                .isAfter(DateTime(2010).subtract(const Duration(days: 1)));
          },
        );
        if (selectedDate != null) {
          Intl.defaultLocale = 'es';
          String formatValue =
              DateFormat('yyyy-MM-dd HH:mm').format(selectedDate);
          String formatField =
              DateFormat('dd MMM, yyyy HH:mm').format(selectedDate);
          controller.dispatchCalendarSelectorCnt.text = formatField;
          controller.onChangeDispatchDate(formatValue);
        }
      },
      decoration: InputDecoration(
        counterText: '',
        label: const Text('Fecha y Hora'),
        prefixStyle: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade400
              : Colors.grey.shade700,
          fontSize: 16,
        ),
        errorMaxLines: 1,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.grey.shade600,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: false,
        fillColor: Colors.grey.shade900,
      ),
    );
  }
}
