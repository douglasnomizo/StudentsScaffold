# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_StudentsNotes_session',
  :secret      => '0f356a8e23ee356a29d7af184c93d345ecaf15a3ef89650f97cd39ca34bfc5ab534044e7be1d73fdcf94f32682529ae04bfea2e0b70d3c33729940f1f69eb638'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
