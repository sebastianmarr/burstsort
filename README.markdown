README
======

This is a Ruby implementation of the burst sort algorithm, which is suited exceptionally well for (very) big sets of strings. It uses the data structure of the burst trie, to store the strings in a cache-efficient and near-sorted manner.

Caveats
-------

Compared to the internal Ruby sort algorithm, this implementation is still quite slow. Performance fixes will follow.

Acknowledgements
----------------

This is implementation of the burst sort algorithm is based on the original paper by Ranjan Sinha and Justin Zobel, which can be found here: [http://goanna.cs.rmit.edu.au/~jz/fulltext/alenex03.pdf](http://goanna.cs.rmit.edu.au/~jz/fulltext/alenex03.pdf)


License: MIT
