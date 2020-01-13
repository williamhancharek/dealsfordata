// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "comment", "link", "notification"]

  recommend() {
    event.preventDefault()
    this.notificationTarget.textContent =  this.linkTarget.value
    this.commentTarget.value = ""

    // `${this.linkTarget.value + this.commentTarget.value}!`
    //
    // this.linkTarget.textContent = ""
    // this.commentTarget.textContent = ""

  }
}
