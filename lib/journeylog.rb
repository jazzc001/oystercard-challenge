require_relative 'journey'

class JourneyLog
    def initialize
        @journey = Journey.new
        @journeys = []
        @pending = "..."
    end
    
    def start(station)
        raise "Still travelling" if @journey.complete? == false && !@journeys == []
        @journeys << { @journey.entry_station = station => @pending }
        current_journey
    end

    def finish(station)
        @journeys.last[@journey.entry_station] = station
        current_journey
    end

    def journeys
        @journeys.clone
    end

    def to_charge
        @journey.complete? == false ? @journey.fare : 0
    end

    private

    def current_journey
        if @journey.complete? 
            @journey
        else
            @journeys.last
        end
         
    end
end