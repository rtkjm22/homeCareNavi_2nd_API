paginate = {
  current_page: @result.current_page,
  prev_page: @result.prev_page,
  next_page: @result.next_page,
  total_page: @result.total_pages
}
json.set! :paginate, paginate
