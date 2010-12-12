require "friendship"

shared_examples_for "friendship storage" do

  it "creates and fetches relationships" do
    subject.friend("john", "paul")
    subject.friend("john", "george")
    subject.friend("john", "ringo")

    subject.friendships("john").sort.should == %w{ringo george paul}.sort
  end

  it "checks if one user is friends with another" do
    subject.friend("john", "paul")
    subject.friend("paul", "john")
    
    subject.friend_of?("john", "paul").should be_true
  end

  it "unfriends a user" do
    subject.friend("john", "paul")
    subject.unfriend("john", "paul")

    subject.friend_of?("john", "paul").should be_false
  end

  it "finds mutual friends" do
    subject.friend("john", "george")
    subject.friend("john", "ringo")
    subject.friend("paul", "george")
    subject.friend("paul", "ringo")

    subject.mutual_friends("john", "paul").should == ["ringo", "george"]
  end

end

