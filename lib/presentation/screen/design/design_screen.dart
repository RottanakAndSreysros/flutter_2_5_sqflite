import 'package:flutter/material.dart';
import 'package:flutter_2_5_sqflite/core/controller/databash_controller.dart';
import 'package:flutter_2_5_sqflite/core/model/text_note_model.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key, this.model});

  final TextNoteModel? model;

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _controller = DatabashController();

  @override
  void initState() {
    if (widget.model != null) {
      _title.text = widget.model!.title;
      _description.text = widget.model!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: widget.model != null
            ? const Text(
                "Edit note",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Add note",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () async {
              final title = _title.text;
              final description = _description.text;
              var date = DateTime.now();
              final time =
                  "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
              if (widget.model == null) {
                await DatabashController()
                    .insertData(
                      model: TextNoteModel(
                        title: title,
                        description: description,
                        date: time,
                      ),
                    )
                    .then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Saved successfully"),
                        ),
                      ),
                    );
                ;
              } else {
                await DatabashController()
                    .editData(
                      model: TextNoteModel(
                        id: widget.model!.id,
                        title: title,
                        description: description,
                        date: time,
                      ),
                    )
                    .then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Editing completed successfully"),
                        ),
                      ),
                    );
                ;
              }
            },
            icon: const Icon(
              Icons.note_add_rounded,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Note title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Note description",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
                maxLines: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
