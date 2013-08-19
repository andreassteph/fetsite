require "spec_helper"

describe FetprofilesController do
  describe "routing" do

    it "routes to #index" do
      get("/fetprofiles").should route_to("fetprofiles#index")
    end

    it "routes to #new" do
      get("/fetprofiles/new").should route_to("fetprofiles#new")
    end

    it "routes to #show" do
      get("/fetprofiles/1").should route_to("fetprofiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fetprofiles/1/edit").should route_to("fetprofiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fetprofiles").should route_to("fetprofiles#create")
    end

    it "routes to #update" do
      put("/fetprofiles/1").should route_to("fetprofiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fetprofiles/1").should route_to("fetprofiles#destroy", :id => "1")
    end

  end
end
