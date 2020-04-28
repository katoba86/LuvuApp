import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {

  List<dynamic> _contacts = new List<dynamic>();

  Future<List> where(String query) async{
    PermissionStatus permissionStatus = await requestPermission(Permission.contacts);
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = (await ContactsService.getContacts(query:query,withThumbnails: true))
          .toList();
      return contacts;
    }else{
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<List> getContacts() async{
    PermissionStatus permissionStatus = await requestPermission(Permission.contacts);
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = (await ContactsService.getContacts(withThumbnails: true))
          .toList();
      return contacts;
    }else{
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<List> getSuggestions(String query) async {
    PermissionStatus permissionStatus = await requestPermission(Permission.contacts);
    if (permissionStatus == PermissionStatus.granted) {
      // Load without thumbnails initially.
      var contacts = (await ContactsService.getContacts(withThumbnails: false))
          .toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
         // Lazy load thumbnails after rendering initial contacts.
      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return; // Don't redraw if no change.
          contact.avatar = avatar;
        });
      }
      return contacts;
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

}