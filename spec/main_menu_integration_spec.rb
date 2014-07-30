RSpec.describe "ZSS Main Menu" do
  context "Prints a menu" do
    it "shows a zombie" do
      actual = `./zss`
      expected = %q{
NUGGGGGH MUST EAT BRAINS
                           \
                                .....
                               C C  /
                              /<   /
               ___ __________/_#__/
              /(- /(\_\________   \
              \ ) \ )_      \o     \
              /|\ /|\       |'     |
                            |     _|
                            /o   __\
                           / '     |
                          / /      |
                         /_/\______|
                        (   _(    <
                         \    \    \
                          \    \    |
                           \____\____\
                           ____\_\__\_\
                         /`   /`     o\
                         |___ |_______|.. .
}
      expect(actual).to include(expected)
    end

    it "should print the list of training paths" do
      pending "The ability to add training paths via. the CLI"
      TrainingPath.create(name: "Running")
      TrainingPath.create(name: "Hand-to-Hand Combat")
      TrainingPath.create(name: "Sneaking")
      actual = `./zss`
      expected = "1. Running" +
                 "2. Hand-to-Hand Combat" +
                 "3. Sneaking"
      expect(actual).to include(expected)
    end

    it "should print graphs that match the progress down the training paths" do
      pending "implementation of skills"
      fail
    end
  end
end
