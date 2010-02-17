# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_hdmovies_session',
  :secret => '86c776e1c64c1320deaeac3d42fd69aab24d00332b0faf368fde74fa1da5814d52716e8a14fc14fcdebbb5a346ce35f4f73782c52005fb45ae527826d722b06c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
