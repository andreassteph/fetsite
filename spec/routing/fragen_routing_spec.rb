require "spec_helper"

describe FragenController do
  describe "routing" do

    it "routes to #index" do
      get("/fragen").should route_to("fragen#index")
    end

    it "routes to #new" do
      get("/fragen/new").should route_to("fragen#new")
    end

    it "routes to #show" do
      get("/fragen/1").should route_to("fragen#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fragen/1/edit").should route_to("fragen#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fragen").should route_to("fragen#create")
    end

    it "routes to #update" do
      put("/fragen/1").should route_to("fragen#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fragen/1").should route_to("fragen#destroy", :id => "1")
    end

  end
end
