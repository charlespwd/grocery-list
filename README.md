# Grocery-list
Turn your json, csv, md, or strings into grocery lists that you can
then search for.

## Example usage
```ruby
require 'grocery'
require 'searcher'

searcher = IGASearcher.new
list = grocery.new('./grocery-list.md', searcher)

list.search_all #=> opens 1 tab per item in your default browser
```

## Formats
### Strings
  Strings are expected to be split by commas.

```ruby
  "spam, egg, bacon, maple syrup" #=> valid
  "spam, egg, \nbacon, maple syrup" #=> invalid
```

### JSON
  Just pass in an array of strings and you're golden.

```ruby
  '["spam", "egg", "bacon", "maple syrup"]'
```

### Markdown File
  Every list items identified by a ` *` is considered an item. Every
line which doesn't respect this isn't.

```markdown
# Grocery List
 * Spam
 * Eggs
 * Bacon
 * Maple syrup

Anything else isn't considered an item.
```

## To do
  * [ ] Implement more searchers? I have IGA.net working in Montreal;
Could be extended?

## License
MIT
