import { Application } from "@hotwired/stimulus"
import Sortable from '@stimulus-components/sortable'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register('sortable', Sortable)
export { application }
