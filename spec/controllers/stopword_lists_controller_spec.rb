require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StopwordListsController do

  # This should return the minimal set of attributes required to create a valid
  # StopwordList. As you add validations to StopwordList, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StopwordListsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all stopword_lists as @stopword_lists" do
      stopword_list = StopwordList.create! valid_attributes
      get :index, {}, valid_session
      assigns(:stopword_lists).should eq([stopword_list])
    end
  end

  describe "GET show" do
    it "assigns the requested stopword_list as @stopword_list" do
      stopword_list = StopwordList.create! valid_attributes
      get :show, {:id => stopword_list.to_param}, valid_session
      assigns(:stopword_list).should eq(stopword_list)
    end
  end

  describe "GET new" do
    it "assigns a new stopword_list as @stopword_list" do
      get :new, {}, valid_session
      assigns(:stopword_list).should be_a_new(StopwordList)
    end
  end

  describe "GET edit" do
    it "assigns the requested stopword_list as @stopword_list" do
      stopword_list = StopwordList.create! valid_attributes
      get :edit, {:id => stopword_list.to_param}, valid_session
      assigns(:stopword_list).should eq(stopword_list)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new StopwordList" do
        expect {
          post :create, {:stopword_list => valid_attributes}, valid_session
        }.to change(StopwordList, :count).by(1)
      end

      it "assigns a newly created stopword_list as @stopword_list" do
        post :create, {:stopword_list => valid_attributes}, valid_session
        assigns(:stopword_list).should be_a(StopwordList)
        assigns(:stopword_list).should be_persisted
      end

      it "redirects to the created stopword_list" do
        post :create, {:stopword_list => valid_attributes}, valid_session
        response.should redirect_to(StopwordList.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved stopword_list as @stopword_list" do
        # Trigger the behavior that occurs when invalid params are submitted
        StopwordList.any_instance.stub(:save).and_return(false)
        post :create, {:stopword_list => {}}, valid_session
        assigns(:stopword_list).should be_a_new(StopwordList)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        StopwordList.any_instance.stub(:save).and_return(false)
        post :create, {:stopword_list => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested stopword_list" do
        stopword_list = StopwordList.create! valid_attributes
        # Assuming there are no other stopword_lists in the database, this
        # specifies that the StopwordList created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        StopwordList.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => stopword_list.to_param, :stopword_list => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested stopword_list as @stopword_list" do
        stopword_list = StopwordList.create! valid_attributes
        put :update, {:id => stopword_list.to_param, :stopword_list => valid_attributes}, valid_session
        assigns(:stopword_list).should eq(stopword_list)
      end

      it "redirects to the stopword_list" do
        stopword_list = StopwordList.create! valid_attributes
        put :update, {:id => stopword_list.to_param, :stopword_list => valid_attributes}, valid_session
        response.should redirect_to(stopword_list)
      end
    end

    describe "with invalid params" do
      it "assigns the stopword_list as @stopword_list" do
        stopword_list = StopwordList.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StopwordList.any_instance.stub(:save).and_return(false)
        put :update, {:id => stopword_list.to_param, :stopword_list => {}}, valid_session
        assigns(:stopword_list).should eq(stopword_list)
      end

      it "re-renders the 'edit' template" do
        stopword_list = StopwordList.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StopwordList.any_instance.stub(:save).and_return(false)
        put :update, {:id => stopword_list.to_param, :stopword_list => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested stopword_list" do
      stopword_list = StopwordList.create! valid_attributes
      expect {
        delete :destroy, {:id => stopword_list.to_param}, valid_session
      }.to change(StopwordList, :count).by(-1)
    end

    it "redirects to the stopword_lists list" do
      stopword_list = StopwordList.create! valid_attributes
      delete :destroy, {:id => stopword_list.to_param}, valid_session
      response.should redirect_to(stopword_lists_url)
    end
  end

end