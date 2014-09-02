module GroceryList
  class FileItemParser < AbstractItemParser
    class << self
      def read(file_path)
        raise ArgumentError unless file_path.is_a? String
        file = IO.read(file_path)
        items_from_file(file)
      end

      private
      def items_from_file(file)
        file.split("\n").map do |line|
          line_to_item(line)
        end.select do |item|
          item.is_a? Item
        end
      end

      def line_to_item(line)
        Item.new(item_name(line)) if is_valid_item(line)
      end

      def is_valid_item(line)
        line.start_with? " *"
      end

      def item_name(line)
        line[2..-1].strip
      end
    end
  end
end
