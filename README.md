# NY FishFinder

### Description
Welcome to NY FishFinder! This simple application allows a user to run queries about species of fish in various popular bodies of water across the state. We also provide information on amenities at the bodies of water in the first query option. This application uses a public data API on Recommended Fishing Lakes and Ponds from New York State Department of Environmental Conservation.

### Install instructions
In order to run the application, download the entire file directory, then execute the file run.rb in the bin folder from your terminal.

Contributors guide
If you are interested in contributing to this application, the following information may be helpful.

The application uses the following models for running queries: County, Waterbody, Fish, and Amenity. County and Waterbody are joined through a CountyWaterbody Class. Waterbody is joined to Fish and Amenity with WaterbodyFish and WaterbodyAmenity Classes. County is joined to Fish and Amenity through the Waterbody table.

The application runs on a SQLite3 database. Tables are named after models in lowercase, pluralizing  names. In the case of a join table title with two words, the second word is pluralized and the words are separated in snake-case (e.g. Model - WaterbodyFish, Table = waterbody_fishes).

### Link to the license for your code

Copyright <2017> <Rochel Levi and Paul Kristapovich>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
