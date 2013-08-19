require "spec_helper"

describe LecturersController do
  describe "routing" do

    it "routes to #index" do
      get("/lecturers").should route_to("lecturers#index")
    end

    it "routes to #new" do
      get("/lecturers/new").should route_to("lecturers#new")
    end

    it "routes to #show" do
      get("/lecturers/1").should route_to("lecturers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lecturers/1/edit").should route_to("lecturers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lecturers").should route_to("lecturers#create")
    end

    it "routes to #update" do
      put("/lecturers/1").should route_to("lecturers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lecturers/1").should route_to("lecturers#destroy", :id => "1")
    end

  end
end
