import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/src/helpers/viewing.dart';
import 'package:instagram/src/views/screens/home/status/status.viewmodel.dart';
import 'package:instagram/src/views/widgets/buttons.dart';
import 'package:instagram/src/views/widgets/input.dart';
import 'package:instagram/src/views/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class StatusView extends StatelessWidget {
  final PickedFile file;
  StatusView(this.file);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StatusViewModel>.reactive(
        onModelReady: (model) => model.init(file),
        builder: (context, model, _) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Add to your story",
                    style: TextStyle(color: Colors.black),
                  ),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                ),
                body: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.memory(model.file),
                        ),
                        Expanded(
                            child: LegendInput(
                          "Ajouter une légende...",
                          onEdit: (text) {
                            model.handleInput("description", text);
                          },
                        ))
                      ]),
                      Divider(),
                      Input(
                        "Ajouter un lieu",
                        onEdit: (text) {
                          model.handleInput("place", text);
                        },
                      ),
                      Divider(),
                      Input(
                        "Hashtags (fun, boat, trip ...)",
                        onEdit: (text) {
                          model.handleInput("tags", text);
                        },
                      ),
                      Viewing.spacing(height: 16),
                      model.isLoading
                          ? Loader()
                          : PrimaryButton(
                              "Partager",
                              action: () => model.submit(context),
                            )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => StatusViewModel());
  }
}
