# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(username: "user1")
user2 = User.create(username: "user2")
user3 = User.create(username: "user3")
user4 = User.create(username: "user4")

artwork1 = Artwork.create(title: "Art1", image_url: "Url1", artist_id: 1 )
artwork2 = Artwork.create(title: "Art2", image_url: "Url2", artist_id: 1 )
artwork3 = Artwork.create(title: "Art3", image_url: "Url3", artist_id: 2 )
artwork4 = Artwork.create(title: "Art4", image_url: "Url4", artist_id: 2 )
artwork5 = Artwork.create(title: "Art5", image_url: "Url5", artist_id: 2 )
artwork6 = Artwork.create(title: "Art6", image_url: "Url6", artist_id: 3 )
artwork7 = Artwork.create(title: "Art6", image_url: "Url7", artist_id: 4 )
artwork8 = Artwork.create(title: "Art7", image_url: "Url8", artist_id: 4 )
artwork9 = Artwork.create(title: "Art8", image_url: "Url9", artist_id: 4 )
artwork10 = Artwork.create(title: "Art10", image_url: "Url10", artist_id: 4 )

share1 = ArtworkShare.create(artwork_id: 1, viewer_id: 2)
share2 = ArtworkShare.create(artwork_id: 2, viewer_id: 3)
share3 = ArtworkShare.create(artwork_id: 3, viewer_id: 4)
share4 = ArtworkShare.create(artwork_id: 4, viewer_id: 1)
share5 = ArtworkShare.create(artwork_id: 5, viewer_id: 2)
share6 = ArtworkShare.create(artwork_id: 6, viewer_id: 2)
share7 = ArtworkShare.create(artwork_id: 7, viewer_id: 3)
share8 = ArtworkShare.create(artwork_id: 8, viewer_id: 4)
share9 = ArtworkShare.create(artwork_id: 8, viewer_id: 1)
share10 = ArtworkShare.create(artwork_id: 3, viewer_id: 1)
