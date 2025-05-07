import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CRUDPage extends StatefulWidget {
  @override
  _CRUDPageState createState() => _CRUDPageState();
}

class _CRUDPageState extends State<CRUDPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  List<ParseObject> records = [];
  ParseObject? selected;

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  void fetchRecords() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      final query = QueryBuilder(ParseObject('Record'))
        ..whereEqualTo('user', currentUser);  // Filter by current user
      final response = await query.query();
      if (response.success && response.results != null) {
        setState(() => records = response.results as List<ParseObject>);
      }
    }
  }

  void saveRecord() async {
    final name = nameCtrl.text.trim();
    final ageText = ageCtrl.text.trim();
    if (name.isEmpty || ageText.isEmpty || int.tryParse(ageText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter valid Name and Age.")));
      return;
    }
    final age = int.parse(ageText);

    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) return;

    final obj = selected ?? ParseObject('Record');
    obj.set('name', name);
    obj.set('age', age);
    obj.set('user', currentUser);  // Set the user reference

    final response = await obj.save();
    if (response.success) {
      nameCtrl.clear();
      ageCtrl.clear();
      selected = null;
      fetchRecords();
    }
  }

  void deleteRecord(ParseObject obj) async {
    final response = await obj.delete();
    if (response.success) fetchRecords();
  }

  void selectForEdit(ParseObject obj) {
    nameCtrl.text = obj.get<String>('name') ?? '';
    ageCtrl.text = obj.get<int>('age')?.toString() ?? '';
    selected = obj;
  }

  void logout() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      await user.logout();
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Page"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Improved TextFields
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: ageCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            SizedBox(height: 16),

            // Save/Update Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: saveRecord,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                  ),
                  child: Text(selected == null ? "Add" : "Update"),
                ),
                if (selected != null)
                  TextButton(
                    onPressed: () {
                      nameCtrl.clear();
                      ageCtrl.clear();
                      setState(() => selected = null);
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
            SizedBox(height: 16),

            // Records List
            Expanded(
              child: ListView.builder(
                itemCount: records.length,
                itemBuilder: (_, i) {
                  final item = records[i];
                  final name = item.get<String>('name') ?? '';
                  final age = item.get<int>('age') ?? 0;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text("$name, $age", style: TextStyle(fontSize: 18)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => selectForEdit(item),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteRecord(item),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}