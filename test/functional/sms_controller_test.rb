require 'test_helper'

class SmsControllerTest < ActionController::TestCase
=begin  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sms)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sms
    assert_difference('Sms.count') do
      post :create, :sms => { }
    end

    assert_redirected_to sms_path(assigns(:sms))
  end

  def test_should_show_sms
    get :show, :id => sms(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sms(:one).id
    assert_response :success
  end

  def test_should_update_sms
    put :update, :id => sms(:one).id, :sms => { }
    assert_redirected_to sms_path(assigns(:sms))
  end

  def test_should_destroy_sms
    assert_difference('Sms.count', -1) do
      delete :destroy, :id => sms(:one).id
    end

    assert_redirected_to sms_path
  end
=end
end
