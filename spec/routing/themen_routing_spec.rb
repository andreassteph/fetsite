require "spec_helper"

describe ThemenController do
  describe "routing" do

    it "routes to #index" do
      get("/themen").should route_to("themen#index")
    end

    it "routes to #new" do
      get("/themen/new").should route_to("themen#new")
    end

    it "routes to #show" do
      get("/themen/1").should route_to("themen#show", :id => "1")
    end

    it "routes to #edit" do
      get("/themen/1/edit").should route_to("themen#edit", :id => "1")
    end

    it "routes to #create" do
      post("/themen").should route_to("themen#create")
    end

    it "routes to #update" do
      put("/themen/1").should route_to("themen#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/themen/1").should route_to("themen#destroy", :id => "1")
    end

  end
end
