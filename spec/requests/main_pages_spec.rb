require 'spec_helper'
require 'shared_examples/shared_examples_for_integration_tests'

describe "Main pages" do

  subject { page }



  describe "Home page" do
  	before { visit root_path }

    let(:pagesummary) {'Smelly Code'}


    it_behaves_like 'a page with summary content'
  end
end