# Grocery-list
Turn your json, csv, md, or strings into grocery lists that you can
then search for.

## Example usage
```ruby
require 'grocery_list'

searcher = GroceryList::IGASearcher.new
GroceryList.search_all('./grocery-list.md', searcher) #=> opens 1 tab/item
```

## Installation
```bash
gem install grocery_list
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
