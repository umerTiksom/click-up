require 'rails_helper'
RSpec.describe Task, type: :model do
  it "is invalid without a title" do
  task = Task.new(tittle: nil)
  expect(task).not_to be_valid
  end
  it "is invalid without a description" do
    task = Task.new(description: nil)
    expect(task).not_to be_valid
  end
  it "is invalid without a status" do
    task = Task.new(status: nil)
    expect(task).not_to be_valid
  end
end