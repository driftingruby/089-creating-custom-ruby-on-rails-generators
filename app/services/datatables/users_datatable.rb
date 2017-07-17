class UsersDatatable < ApplicationDatatable
  delegate :edit_user_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    users.map do |user|
      [].tap do |column|
        column << nil # something
      end
    end
  end

  # Returns the count of records.
  def count
    User.count
  end

  def total_entries
    users.total_count
    # will_paginate
    # users.total_entries
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    # will_paginate
    # users = User.page(page).per_page(per_page)
    users = User.order("#{sort_column} #{sort_direction}")
    users = users.page(page).per(per_page)
    users = users.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w()
  end
end