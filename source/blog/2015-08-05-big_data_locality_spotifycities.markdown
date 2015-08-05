---
title: Finding distinctive features in complex data
date: 2015-04-03
author: David Ochoa
type: Opinion
tags: opinion
standfirst: From the music we listen to the tissue driving genes
published: true
---

Last month, Spotify published in their [Insights blog](https://insights.spotify.com) an experiment that attracted my attention. They named it *Musical Map: Cities of the World*. The idea was to use their huge database of user habits to find music "distinctive" for each city in the world. The definition of "distinctive" would be those songs that are often listened in a given city, but not that much in other ones. This local preference on the music taste is a very intuitive concept that usually attends to cultural differences. In the case of my hometown for instance, the music preference is driven by the local Basque music, hardly understood in relatively close cities. A similar study was also performed by Spotify in 2014 when they tried to find the [Distinctive Fourth of July Songs by State](https://insights.spotify.com/us/2014/07/01/distinctive-fourth-of-july-songs-by-state/#more-171).  The interesting part about this concept is the ability to find local patterns that distinguish small communities within a much larger group.

There are plenty of possible applications to this knowledge on local differences. One of the most obvious is advertising. I can imagine a grocery store advertising certain products in a city where a local festivity is taking place, while offering completely different products in all nearby branches. In my case, I've been interested on these concepts for some time. In biological data, very frequently you want to find features that explain why a given group is different. For example, someone might wonder which are the genes driving a given tissue. Since there are many processes occurring in the cells that are not directly related with the tissue membership, you can't simply ask which are the most differentially regulated genes. A more interesting question would be to find the genes that are regulated on these tissues, that are not regulated in any other ones.

How you define the question also has different implications. First of all you have to define the context in which you want to find the "distinctive" feature. In the Spotify example, the same way they find distinctive songs for cities, they could repeat the analysis in a more general context - per country - or in a more specific one - per building block. The answers to these questions could change dramatically and so could their interpretation.  Another problem comes when we define against what we want to compare. It's not the same if we compare the songs of a city versus the rest of the world, where most populated regions can be more represented, than if we compare them against each city individually.

As the *so-called* big data continues flowing many questions would require finding the commonalities between local features. From my limited knowledge in this area, there are big similarities between the approaches used in different social and scientific areas, that could potentially be transferred for a better understanding of this problem.