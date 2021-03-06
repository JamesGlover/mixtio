require "rails_helper"

RSpec.describe Authentication::ControllerConcern, type: :controller do

  let(:controller)  { AnonymousController.new }

  before do
    @test_user = create(:user, username: "user1")
  end

  before(:each) do
    allow(Authentication::Ldap).to receive(:authenticate).with("user1", "password").and_return(true)
    allow(Authentication::Ldap).to receive(:authenticate).with("user1", "badpassword").and_return(false)
  end

  it "should be able to authenticate the user" do
    expect(controller.authenticate?("user1", "password")).to be_truthy
    expect(controller.authenticate?("user1", "badpassword")).to be_falsey
  end

  it "should be able to check if the user is signed in" do
    controller.authenticate?("user1", "password")
    expect(controller.current_user).to be_signed_in
    expect(controller.current_user.username).to eq("user1")
    expect(controller.signed_in?).to be_truthy
  end

  it "should be able to sign a user out" do
    controller.authenticate?("user1", "password")
    controller.sign_out!
    expect(controller.session[:username]).to be_nil
    expect(controller.current_user).to_not be_signed_in
  end

  it "should redirect to sign in path if not authenticated" do
    @controller = AnonymousController.new
    get :index
    expect(response).to be_redirect

    @controller = AnonymousController.new
    allow(@controller.current_user).to receive(:signed_in?).and_return(true)
    get :index
    expect(response).to be_successful
  end

end