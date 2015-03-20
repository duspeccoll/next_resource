# next_resource

This plugin takes as input a range of collections (selected from the drop-down list), pulls all of the Resource JSON objects from the database, isolates only those collections whose IDs begin with the range's letter, and determines the next collection number up in the sequence.

It is useful for archivists who are accessioning a collection and need to quickly determine what the next collection number is, without having to browse through the whole list.

In the future I'd like to provide thecapability of creating a new collection record directly from this plug-in, but I don't know if that fits with our workflows here (since most of the time collection records get spawned from an Accession).

In all likelihood this will only be useful here at DU since it's designed specifically for the way we classify collections here, but others may find it useful as an example of how a plugin with this sort of functionality might work. I'm also open to suggestions on how to improve it; I'm not much of a Rails or jQuery developer yet.

Questions? E-mail kevin.clair@du.edu.
