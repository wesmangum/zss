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
  end
end
