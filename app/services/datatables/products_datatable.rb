class ProductsDatatable < ApplicationDatatable
  delegate :edit_product_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    products.map do |product|
      [].tap do |column|
        column << nil # something
      end
    end
  end

  # Returns the count of records.
  def count
    Product.count
  end

  def total_entries
    products.total_count
    # will_paginate
    # products.total_entries
  end

  def products
    @products ||= fetch_products
  end

  def fetch_products
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    # will_paginate
    # products = Product.page(page).per_page(per_page)
    products = Product.order("#{sort_column} #{sort_direction}")
    products = products.page(page).per(per_page)
    products = products.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w()
  end
end