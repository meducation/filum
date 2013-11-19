# Filum

Filum is a logger which automatically adds a context id to each log line.

This is useful when logging in multi threaded and multi process environments. 
Filum stores a context id representing a single operation. Each line logged 
during that operation automatically contains the context id. 

This can be used for operations which span multi process. A context id can be
passed between the processes. Log lines from both processes will contain the
context id, allowing the tracking of the single operation through
all the processes individual log files.

## Installation

Add this line to your application's Gemfile:

    gem 'filum'

And then execute:

    $ bundle

## Usage

TODO

## Contributing

Firstly, thank you!! :heart::sparkling_heart::heart:

We'd love to have you involved. Please read our [contributing guide](https://github.com/meducation/inquisitio/tree/master/CONTRIBUTING.md) for information on how to get stuck in.

### Contributors

This project is managed by the [Meducation team](http://company.meducation.net/about#team). 

These individuals have come up with the ideas and written the code that made this possible:

- [Jeremy Walker](http://github.com/iHID)
- [Malcolm Landon](http://github.com/malcyL)
- [Charles Care](http://github.com/ccare)

## Licence

Copyright (C) 2013 New Media Education Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

A copy of the GNU Affero General Public License is available in [Licence.md](https://github.com/meducation/inquisitio/blob/master/LICENCE.md)
along with this program.  If not, see <http://www.gnu.org/licenses/>.
