shared_examples 'a page that lets me delete' do
  it {should have_link('delete', href: delete_link)}
  it "should be able to delete an item" do
    expect {click_link('delete', match: :first)}.to change(model_class, :count).by(-1)
  end
end

shared_examples 'a page with a standard title' do
  it {should have_title(full_title(pagetitle))}
end
shared_examples 'a page with summary content' do
  it {should have_content(pagesummary)}
end

shared_examples 'a page with an error' do
  it {should have_content('error')}
end
shared_examples 'a page that lets me create a new item' do
  it { should have_link('Create new', href: new_item_link)}
end
shared_examples 'a page with an edit link' do
  it { should have_link('edit', href: edit_link)}
end

shared_examples 'a page with pagination' do |clazz|
  before (:all) do
    clazz.delete_all
    30.times {FactoryGirl.create(clazz.name.underscore.to_sym)}
  end
  after (:all) {clazz.delete_all}
  it {should have_selector('div.pagination')}
  it 'should list each item' do
    model_class.paginate(page: 1).each do |item|
      expect(subject).to have_selector('li', text: item.name)
    end
  end
end

shared_examples "a page that doesn't create with invalid information" do |clazz|
  before do
    # required_properties.each do |property|
    #   if property.is_a? Hash
    #     property = property.keys.first
    #   end
    #   required_field = property.to_s.humanize
    #   fill_in required_field,             with: ' '
    # end
    populate_required_properties :with_invalid
  end
  it "should not change item count" do
    expect {click_button submit}.not_to change(clazz, :count)
  end
end


shared_examples "a page that creates a new item with valid information" do |clazz|
  before do
    populate_required_properties :with_valid
  end
  it "should  change item count" do
    expect {click_button submit}.to change(clazz, :count).by(1)
  end
end

def populate_required_properties valid_or_not
  required_properties.each do |required_field|

      if required_field.is_a? Hash
        field = required_field.keys.first
        value = required_field[field][:valid]
        field_type = required_field[field][:field_type]
      else
        field = required_field
        value = valid_string
      end
      field = field.to_s.humanize

      value = (valid_or_not== :with_valid) ? value : ''

      if field_type == :select
        select(value, :from => field)
      else
        fill_in field, with: value
      end
    end
end


def valid_string
  "aafafafwfg"
end

shared_examples 'a page that errors with invalid information' do
  before do
    # required_properties.each do |property|
    #   if property.is_a? Hash
    #     property = property.keys.first
    #   end
    #   required_field = property.to_s.humanize
    #   fill_in required_field,             with: ' '
    # end
    populate_required_properties :with_invalid
    click_button submit
  end
  include_examples 'a page with an error'
end

shared_examples 'a page that updates item with valid information' do
  before do
    # required_properties.each do |required_field|
    #   if required_field.is_a? Hash
    #     field = required_field.keys.first
    #     value = required_field[field][:valid]

    #   else
    #     field = required_field
    #     value = valid_string
    #   end
    #   field = field.to_s.humanize
    #   fill_in field,             with: value
    # end
     populate_required_properties :with_valid
    click_button submit
  end

  specify "updates the properties" do

    required_properties.each do |property|
      if property.is_a? Hash
        field = property.keys.first
        value = property[field][:expected_update_value] || property[field][:valid]
      else
        field = property
        value = valid_string
      end
      expect(item.reload[field]).to eq value
    end

  end
end