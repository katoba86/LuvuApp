
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {

  var  retFunc;
  ContactsList(
      {@required this.retFunc});

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactsList> {
  List<Contact> _contacts;


  @override
  initState() {
    super.initState();
    refreshContacts();
  }

  refreshContacts() async {
    PermissionStatus permissionStatus = await requestPermission(Permission.contacts);
    if (permissionStatus == PermissionStatus.granted) {
      // Load without thumbnails initially.
      var contacts = (await ContactsService.getContacts(withThumbnails: false))
          .toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
      setState(() {
        _contacts = contacts;
      });

      // Lazy load thumbnails after rendering initial contacts.
      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return; // Don't redraw if no change.
          setState(() => contact.avatar = avatar);
        });
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }


  Future<PermissionStatus> requestPermission(Permission permission) async {
        return await permission.request();
  }


  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: _contacts != null
            ? ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          itemCount: _contacts?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Contact c = _contacts?.elementAt(index);
            return ListTile(
              onTap: () {
                widget.retFunc(c);
                Navigator.pop(context);
              },
              leading: (c.avatar != null && c.avatar.length > 0)
                  ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                  : CircleAvatar(child: Text(c.initials())),
              title: Text(c.displayName ?? ""),

            );
          },
        )
            : Center(child: CircularProgressIndicator(),),

    );
  }
}