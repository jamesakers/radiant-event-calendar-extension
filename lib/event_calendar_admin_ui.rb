module EventCalendarAdminUI

 def self.included(base)
   base.class_eval do

      attr_accessor :calendar, :event
      alias_method :calendars, :calendar
      alias_method :events, :event

      def load_default_regions_with_event_calendar
        load_default_regions_without_event_calendar
        @calendar = load_default_calendar_regions
        @event = load_default_event_regions
      end

      alias_method_chain :load_default_regions, :event_calendar

      protected

        def load_default_calendar_regions
          returning OpenStruct.new do |calendar|
            calendar.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{edit_header edit_form}
              edit.form.concat %w{edit_name edit_ical}
              edit.form_bottom.concat %w{edit_timestamp edit_buttons}
            end
            calendar.index = Radiant::AdminUI::RegionSet.new do |index|
              index.thead.concat %w{name_header url_header refresh_header action_header}
              index.tbody.concat %w{name_cell url_cell refresh_cell action_cell}
              index.bottom.concat %w{buttons}
            end
            calendar.remove = calendar.index
            calendar.new = calendar.edit
          end
        end

        def load_default_event_regions
          returning OpenStruct.new do |event|
            event.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{edit_header edit_form}
              edit.form.concat %w{edit_event edit_date edit_venue}
              edit.form_bottom.concat %w{edit_timestamp edit_buttons}
            end
            event.index = Radiant::AdminUI::RegionSet.new do |index|
              index.top.concat %w{help_text}
              index.thead.concat %w{date_header title_header time_header location_header recurrence_header modify_header}
              index.tbody.concat %w{date_cell title_cell time_cell location_cell recurrence_cell modify_cell}
              index.bottom.concat %w{buttons}
            end
            event.remove = event.index
            event.new = event.edit
          end
        end
      
    end
  end
end

