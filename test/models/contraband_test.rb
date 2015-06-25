require 'test_helper'

class ContrabandTest < ActiveSupport::TestCase
  setup :initialize_example_attrs

  test "contraband must have an owner" do
    cb = Contraband.new
    refute cb.save
  end

  test "can get the owner of contraband" do
    cb = contrabands(:tswift)
    assert_equal cb.user, users(:brit)
  end

  test "contraband may have a custom name instead of filename" do
    cb = contrabands(:tswift)
    assert_equal cb.name, 'bad_blood'
    cb.name = 'mad_love'
    assert cb.save
    assert_equal cb.name, 'mad_love'
  end

  test "contraband must be in a curation" do
    custom_attrs = {
      name: 'glass swords',
      user: users(:brit),
      curation: nil
    }
    attrs = @file_attrs.merge(custom_attrs)
    rustie = Contraband.new(attrs)
    refute rustie.save

    rustie.curation = curations(:brits_music)
    assert_equal rustie.curation, curations(:brits_music)
    assert rustie.save
  end

  test "contraband must be under 10mb" do
    cb = Contraband.new(@file_attrs)
    assert cb.save

    cb.upload_file_size = 10999999
    refute cb.save
  end

  def initialize_example_attrs
    @file_attrs = {
      user_id: 1,
      upload_file_size: 8888888,
      upload_file_name: 'foo.bar',
      upload_updated_at: DateTime.now,
      upload_content_type: 'text/bar',
      curation: curations(:brits_music)
    }
  end
end
