require "spec_helper"

describe CalendarsController do
  describe "routing" do

    it "routes to #index" do
      get("/calendars").should route_to("calendars#index")
    end

    it "routes to #new" do
      get("/calendars/new").should route_to("calendars#new")
    end

    it "routes to #show" do
      get("/calendars/1").should route_to("calendars#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calendars/1/edit").should route_to("calendars#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calendars").should route_to("calendars#create")
    end

    it "routes to #update" do
      put("/calendars/1").should route_to("calendars#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calendars/1").should route_to("calendars#destroy", :id => "1")
    end

  end
end
