require "spec_helper"

describe GremienController do
  describe "routing" do

    it "routes to #index" do
      get("/gremien").should route_to("gremien#index")
    end

    it "routes to #new" do
      get("/gremien/new").should route_to("gremien#new")
    end

    it "routes to #show" do
      get("/gremien/1").should route_to("gremien#show", :id => "1")
    end

    it "routes to #edit" do
      get("/gremien/1/edit").should route_to("gremien#edit", :id => "1")
    end

    it "routes to #create" do
      post("/gremien").should route_to("gremien#create")
    end

    it "routes to #update" do
      put("/gremien/1").should route_to("gremien#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/gremien/1").should route_to("gremien#destroy", :id => "1")
    end

  end
end
