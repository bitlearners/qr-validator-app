
App.require_common


firebase_instances = [
  {
    instance: :task_reminder_firebase,
    firebase_db_url: ENV['firebase_db_url'],
    firebase_auth_key: ENV['firebase_auth_key'],
    firebase_db_root_path: ENV['firebase_db_root_path'],
  },
]

App.connect_firebase_instances(firebase_instances)
