# ConvertToSortedYaml

A script to convert _all_ `json` or `code-profile` files into `yml` file which is sorted. The yaml file is saved into the same folder with the extension `.yml` appended.

The sorted yml file is useful for comparing in a diff tool.

This is useful for comparing VS Code Profiles, or other json files.

# Usage

To compare VS Code profiles:
1. In VS Code, export the profiles into this folder
2. run `ruby convert_to_sorted_yaml.rb`
3. use a diff tool to compare the yml files generated

To run the tests:
1. run `bundle install`
2. run `
# Technical Notes

- VS Code Profiles has strings of json nested within other json elements. Extra steps were taken to convert these nested strings back into json for further sorting.

# License

(The MIT License + Free Software Foundation Advertising Prohibition)

Copyright (c) 2024 Gregory N. Houston

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or other
dealings in this Software without prior written authorization.
