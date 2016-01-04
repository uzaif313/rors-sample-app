module ApplicationHelper

  def full_title(page_title = '')
   base_title = "Static Page Sample App"
   if page_title.to_s.empty?
     base_title
   else
     page_title + "|" + base_title
   end
 end
end
