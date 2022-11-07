require_relative './../../app'
App.require_common


firebase_instances = [
  {
    instance: :firebase,
    firebase_db_url: ENV['firebase_db_url'],
    firebase_auth_key: ENV['firebase_auth_key'],
    firebase_qr_db_root_path: ENV['firebase_qr_db_root_path'],
    firebase_user_db_root_path: ENV['firebase_user_db_root_path'],
  },
]

App.connect_firebase_instances(firebase_instances)
