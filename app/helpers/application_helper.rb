module ApplicationHelper

	# Returns the full title on a per=page basis
	def full_title(page_title)
		base_title = "Treebook"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def bootstrap_paperclip_picture(form, paperclip_object)
		if form.object.send("#{paperclip_object}?")
			content_tag(:div, class: 'control-group') do
				content_tag(:label, "Current #{paperclip_object.to_s.titleize}", class: 'control-label') + 
				content_tag(:div, class: 'controls') do
					image_tag form.object.send(paperclip_object).send(:urkl, :small)
				end
			end			
		end
	end

	def status_document_link(status)
		
		if status.document
			content_tag(:span, "Attachment", class: "label label-info") +
			link_to(status.document.attachment_file_name, @status.document.attachment. url)
		end
	end

	def avatar_profile_link(user, image_options={}, html_options={})
		avatar_url = user.avatar? ? user.avatar.url(:small) : nil
		link_to(image_tag(avatar_url, image_options), profile_path(user.profile_name)) 
	end

	def flash_class(type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-success"
		else
			""
		end
	end
end
