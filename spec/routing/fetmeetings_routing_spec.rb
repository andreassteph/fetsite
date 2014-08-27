require "spec_helper"

describe FetmeetingsController do
  describe "routing" do

    it "routes to #index" do
      get("/fetmeetings").should route_to("fetmeetings#index")
    end

    it "routes to #new" do
      get("/fetmeetings/new").should route_to("fetmeetings#new")
    end

    it "routes to #show" do
      get("/fetmeetings/1").should route_to("fetmeetings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fetmeetings/1/edit").should route_to("fetmeetings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fetmeetings").should route_to("fetmeetings#create")
    end

    it "routes to #update" do
      put("/fetmeetings/1").should route_to("fetmeetings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fetmeetings/1").should route_to("fetmeetings#destroy", :id => "1")
    end

  end
end
