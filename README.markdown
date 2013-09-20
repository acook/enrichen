Enrichen
========

Enrich your life.

A system to rapidly configure machines with your packages and settings.


Enriching a Machine
-------------------


### Local Install

1. Have `curl` and `bash` available.
2. Install its other prerequisites as well as Enrichen itself:

~~~sh
\curl -L https://raw.github.com/acook/enrichen/master/setup/local_install | bash
~~~

If you wish to apply a set of Enrichments at the same time you can pass in the github repo like this:

~~~sh
\curl -L https://raw.github.com/acook/enrichen/master/setup/local_install | bash -s gh:acook/enrichments/ruby_workstation
~~~

You may also pass in a path or any valid git URI.

Once Enrichen is installed you can use it to apply additional Enrichments to the machine:

~~~sh
enrich gh:acook/enrichments/nginx
~~~


### Remote Install

1. Have `SSH` installed on the local and remote machines.
2. Have `Enrichen` installed on the local machine.
3. Then use the `remote` command:

~~~sh
enrich remote user@example.com
~~~

If you wish to apply a set of Enrichments at the same time you can pass in the github repo like this:

~~~sh
enrich remote user@example.com with acook/enrichments/ruby_webserver
~~~

You may also pass in a path or any valid git URI. Multiple Enrichments can be comma delimited.

The same `enrich remote` command can be used to apply additional Enrichments at any time.


### Remote Install Without Local Enrichen

If you do **not** have Enrichen installed locally and for some reason do not wish to you can still Enrich remote machines like this:

~~~sh
ssh user@example.com 'bash -s' < https://raw.github.com/acook/enrichen/master/setup/remote_install
~~~

With Enrichment specified:

~~~sh
ssh user@example.com 'bash -s gh:acook/enrichments/ruby_workstation' < https://raw.github.com/acook/enrichen/master/remote_install.bash
~~~


*Anthony M. Cook 2013 - http://github.com/acook | @anthony_m_cook | http://anthonymcook.com*

