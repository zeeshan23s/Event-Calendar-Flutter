import 'package:event_calendar/model/event_model.dart';
import 'package:event_calendar/util/dimenstions.dart';
import 'package:event_calendar/provider/event_provider.dart';
import 'package:event_calendar/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  final Event? event;
  const EditEventScreen({Key? key, this.event}) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop()),
        actions: [
          GestureDetector(
            onTap: () => saveForm(widget.event),
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.heightFactor * 10),
                child: Icon(Icons.save, size: Dimensions.heightFactor * 24)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.heightFactor * 12),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              SizedBox(height: Dimensions.heightFactor * 15),
              buildDescription(),
              SizedBox(height: Dimensions.heightFactor * 15),
              buildDateTimePickers(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
      style: TextStyle(fontSize: Dimensions.heightFactor * 24),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Add Title',
      ),
      onFieldSubmitted: (_) => saveForm(widget.event),
      validator: (title) =>
          title != null && title.isEmpty ? 'Title cannot be empty' : null,
      controller: titleController);

  Widget buildDescription() => TextFormField(
      style: TextStyle(fontSize: Dimensions.heightFactor * 24),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Add Description',
      ),
      onFieldSubmitted: (_) => saveForm(widget.event),
      validator: (title) =>
          title != null && title.isEmpty ? 'Description cannot be empty' : null,
      controller: descriptionController);

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: "FROM",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropdownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: true),
                )),
            Expanded(
                child: buildDropdownField(
              text: Utils.toTime(fromDate),
              onClicked: () => pickFromDateTime(pickDate: false),
            ))
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: "To",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropdownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickToDateTime(pickDate: true),
                )),
            Expanded(
                child: buildDropdownField(
              text: Utils.toTime(toDate),
              onClicked: () => pickToDateTime(pickDate: false),
            ))
          ],
        ),
      );

  Widget buildDropdownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
          child
        ],
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future saveForm(event) async {
    final isValid = _fromKey.currentState!.validate();

    if (isValid) {
      final newEvent = Event(
          title: titleController.text,
          description: descriptionController.text,
          from: fromDate,
          to: toDate,
          createdTime: DateTime.now());

      final isEditing = widget.event != null;

      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, newEvent);
      } else {
        provider.addEvent(newEvent);
      }

      Navigator.pop(context);
    }
  }
}
