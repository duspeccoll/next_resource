# Next Resource

This plugin queries our ArchivesSpace instance for the next resource identifier in our numbering sequence for a given collecting area, then generates a new minimal resource record (ID, temporary title, date and extent) based on that identifier.

## Background

DU assigns local call numbers to its archival collections based on the order in which they are added to one of our four main collecting areas:

* Beck Archives (local call numbers beginning with B)
* Carson Brierly Giffin Dance Library (local call numbers beginning with D)
* University Archives (local call numbers beginning with U)
* Special Collections manuscripts (local call numbers beginning with M)

The numbering schema is the collecting area indicator, followed by a zero-padded three-digit number identifying its order in the sequence. For example, "B005" (the National Asthma Center records) indicates that it is the fifth collection added to the Beck Archives.

## How the plugin works

next_resource contains a [backend API call](https://github.com/duspeccoll/next_resource/blob/master/backend/controllers/next_resource.rb) that takes as input parameter the collecting area to which a resource should be added. It then gets the list of all resources in the database, builds an array of just those resources within the provided collecting area, and checks to see what the last number in the sequence is. It then iterates it by one and returns the resulting identifier.

The frontend allows the user to select the desired collecting area; it then returns the next identifier to the user with the option to create a new resource record using it. When the "Create Record" button is clicked, a new minimal collection record will be created; the user is then re-directed to that record to make whatever edits are required to complete it.

## Screenshots

![Introductory screenshot, displaying the collecting area picker](http://jackflaps.net/img/next_resource_1.png)

The index page, displaying the form where the user may select their desired collecting area.

![When the range is selected, the plugin finds and displays the next call number up](http://jackflaps.net/img/next_resource_2.png)

When the collecting area is selected, a form appears with the next resource ID in sequence for the selected collecting area; the user can then either assign a new title to the new resource, or cancel resource creation.

Once the resource is created, the user is directed to view the new resource, from which they may make further edits if they wish.

## Questions

E-mail the author ( kevin dot clair at du dot edu ) or [find me on Twitter](https://twitter.com/jackflaps).
