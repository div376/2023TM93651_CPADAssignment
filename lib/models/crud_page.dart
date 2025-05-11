import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CRUDPage extends StatefulWidget {
  @override
  _CRUDPageState createState() => _CRUDPageState();
}

class _CRUDPageState extends State<CRUDPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController searchCtrl = TextEditingController();

  List<ParseObject> records = [];
  List<ParseObject> filteredRecords = [];
  ParseObject? selected;
  String sortBy = 'Name';

  @override
  void initState() {
    super.initState();
    fetchRecords();
    searchCtrl.addListener(() {
      filterRecords();
    });
  }

  void fetchRecords() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      final query = QueryBuilder(ParseObject('Record'))
        ..whereEqualTo('user', currentUser);
      final response = await query.query();
      if (response.success && response.results != null) {
        records = response.results as List<ParseObject>;
        filterRecords();
      }
    }
  }

  void filterRecords() {
    final search = searchCtrl.text.toLowerCase();
    setState(() {
      filteredRecords = records
          .where((item) =>
              (item.get<String>('name') ?? '')
                  .toLowerCase()
                  .contains(search))
          .toList();
      sortRecords();
    });
  }

  void sortRecords() {
    filteredRecords.sort((a, b) {
      if (sortBy == 'Name') {
        return (a.get<String>('name') ?? '')
            .compareTo(b.get<String>('name') ?? '');
      } else {
        return (a.get<int>('age') ?? 0)
            .compareTo(b.get<int>('age') ?? 0);
      }
    });
  }

  void saveRecord() async {
    final name = nameCtrl.text.trim();
    final ageText = ageCtrl.text.trim();
    if (name.isEmpty || ageText.isEmpty || int.tryParse(ageText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid Name and Age.")));
      return;
    }

    final age = int.parse(ageText);
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) return;

    final obj = selected ?? ParseObject('Record');
    obj.set('name', name);
    obj.set('age', age);
    obj.set('user', currentUser);

    final response = await obj.save();
    if (response.success) {
      nameCtrl.clear();
      ageCtrl.clear();
      selected = null;
      fetchRecords();
    }
  }

  void deleteRecord(ParseObject obj) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Record"),
        content: Text("Are you sure you want to delete '${obj.get<String>('name')}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      final response = await obj.delete();
      if (response.success) 
       setState(() {
      fetchRecords();
       });
    }
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("✨ User Records"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigoAccent.shade100, Colors.deepPurple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.fromLTRB(16, 80, 16, 16),
        child: Column(
          children: [
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        labelText: "👤 Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: ageCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "🎂 Age",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: saveRecord,
                          icon: Icon(Icons.save),
                          label: Text(selected == null ? "Add" : "Update"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        if (selected != null)
                          TextButton(
                            onPressed: () {
                              nameCtrl.clear();
                              ageCtrl.clear();
                              setState(() => selected = null);
                            },
                            child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      hintText: "🔍 Search by name",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: sortBy,
                  underline: SizedBox(),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  items: ['Name', 'Age'].map((s) => DropdownMenuItem(value: s, child: Text("Sort by $s"))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        sortBy = val;
                        sortRecords();
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredRecords.isEmpty
                  ? Center(
                      child: Text(
                        "No records found.",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredRecords.length,
                      itemBuilder: (_, i) {
                        final item = filteredRecords[i];
                        final name = item.get<String>('name') ?? '';
                        final age = item.get<int>('age') ?? 0;
                        final createdAt = item.createdAt?.toLocal().toString().split('.')[0] ?? '';
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 6,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            title: Text(
                              "$name, $age years",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text("Created at: $createdAt"),
                            trailing: Wrap(
                              spacing: 10,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.indigo),
                                  onPressed: () => selectForEdit(item),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.redAccent),
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