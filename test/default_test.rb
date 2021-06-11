require "test_helper"

class DefaultTest < Minitest::Spec
  Song  = Struct.new(:title, :album, :composer)
  Album = Struct.new(:name, :songs, :artist)
  Artist = Struct.new(:name)

  class AlbumForm < TestForm
    property :name, default: "Wrong"

    collection :songs do
      property :title, default: "It's Catching Up"
    end
  end

  it do
    form = AlbumForm.new(Album.new(nil, [Song.new]))

    assert_equal form.name, "Wrong"
    assert_equal form.songs[0].title, "It's Catching Up"
  end


  class AlbumTestForm < TestForm
    property :name, default: -> { my_method }

    def my_method
      :foobar
    end
  end

  it ":default proc" do
    form = AlbumTestForm.new(Album.new(nil))
    assert_equal form.name, :foobar
  end
end
