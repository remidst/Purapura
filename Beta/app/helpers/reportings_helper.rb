module ReportingsHelper

	def reporting_header(reporting)
		contact = reporting.contact
		publisher = reporting.publisher
		publisher == contact.care_manager ? receiver = contact.service_provider : receiver = contact.care_manager

		if publisher == current_user
			"#{receiver.username}様に送信した書類"
		else
			"#{receiver.username}様から書類が共有されました"
		end
	end

end
