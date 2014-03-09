## USFX to ES
This takes the USFX (scripture in XML) format and dumps it into Elastic Search.

### Quickstart Guide

Assuming you're using Mac and already have Home Brew installed, just install elasticsearch: `brew install elasticsearch`

Then run it: `elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml`

Then do your typical bundle spiel: `bundle`

### Import the Bible

Once you're ready, just run the included script (pointed to the WEB USFX Bible): `./usfxes.rb`. It'll take a bit of time, but shortly thereafter you can check ElasticSearch and every verse will be it's own document. Currently we store the Bible like this:

Index: web (translation code) 
Type: book (3 character code) 
Document ID: Full book C:V (book chapter:verse)

You can easily use the Elastic Search Head gui (see link below) to search for a specific verse. Eg: JHN 3:16

### More Information

* [Elastic Search Docs](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/index.html)
* [What is an Elastic Search index?](http://www.elasticsearch.org/blog/what-is-an-elasticsearch-index/)
* [Elastic Search Head (GUI)](http://mobz.github.io/elasticsearch-head/)