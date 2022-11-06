import { Application } from "@hotwired/stimulus"

// import Rails from '@rails/ujs'
//import Appjs from "@app_js"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


