require File.dirname(__FILE__) + '/../test_helper'
require 'asynapse_files_controller'

# Re-raise errors caught by the controller.
class AsynapseFilesController; def rescue_action(e) raise e end; end

class AsynapseFilesControllerTest < Test::Unit::TestCase
  fixtures :asynapse_files

  def setup
    @controller = AsynapseFilesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
