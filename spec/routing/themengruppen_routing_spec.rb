require "spec_helper"

describe ThemengruppenController do
  describe "routing" do

    it "routes to #index" do
      get("/themengruppen").should route_to("themengruppen#index")
    end

    it "routes to #new" do
      get("/themengruppen/new").should route_to("themengruppen#new")
    end

    it "routes to #show" do
      get("/themengruppen/1").should route_to("themengruppen#show", :id => "1")
    end

    it "routes to #edit" do
      get("/themengruppen/1/edit").should route_to("themengruppen#edit", :id => "1")
    end

    it "routes to #create" do
      post("/themengruppen").should route_to("themengruppen#create")
    end

    it "routes to #update" do
      put("/themengruppen/1").should route_to("themengruppen#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/themengruppen/1").should route_to("themengruppen#destroy", :id => "1")
    end

  end
end
