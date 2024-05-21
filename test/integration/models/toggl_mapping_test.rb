# frozen_string_literal: false

require_relative '../../test_helper'

class TogglMappingTest < T2r::IntegrationTest
  fixtures :all

  def setup
    @user = users(:jsmith)
  end

  test 'deleting time entry deletes relevant toggl mappings' do
    time_entry = time_entries(:entry_001)
    
    mapping_1 = TogglMapping.create(
      toggl_id: 201,
      time_entry_id: time_entry.id,
      created_at: DateTime.strptime('2024-02-22T15:30:04+00:00')
    )
    mapping_2 = TogglMapping.create(
      toggl_id: 202,
      time_entry_id: time_entry.id,
      created_at: DateTime.strptime('2024-02-22T15:30:04+00:00')
    )

    assert time_entry.toggl_mapping_ids.include? mapping_1.id
    assert time_entry.toggl_mapping_ids.include? mapping_2.id

    assert time_entry.destroy
    
    refute TogglMapping.exists? mapping_1.id
    refute TogglMapping.exists? mapping_2.id
  end
end
