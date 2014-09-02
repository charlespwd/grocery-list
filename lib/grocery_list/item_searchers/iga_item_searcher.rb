module GroceryList
  class IGASearcher < AbstractSearcher
    attr :search_options

    @@search_url = "http://magasin.iga.net/Search/BasicSearch.aspx?Search="

    @@valid_options = [
      :priceDesc,
      :priceAsc,
      :DisplayNameDesc,
      :DisplayNameAsc,
    ]

    def initialize(search_option = :priceAsc)
      @search_options = search_option
    end

    def search(item)
      raise ArgumentError, "#{item} isn't an Item" unless item.is_a? Item
      Launchy.open url(item.item_name)
    end

    def search_options=(option = :priceAsc)
      raise ArgumentError, "#{option} is an invalid option" unless @@valid_options.include? option
      @search_options = option
    end

    def search_options
      @search_options
    end

    private
    def url(item_name)
      "#{@@search_url}#{url_encode(item_name)}#{encoded_options}"
    end

    def url_encode(str)
      str.gsub(/ /, '%20')
    end

    def encoded_options
      @search_options ? "&sort=#{@search_options.to_s}" : ""
    end
  end
end

